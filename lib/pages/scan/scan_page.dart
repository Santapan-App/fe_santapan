import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:santapan_fe/core/app_assets.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';
import 'package:santapan_fe/pages/scan/helper.dart';
import 'package:santapan_fe/pages/scan/scan_result_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _image;
  late Helper _modelHelper;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _modelHelper = Helper();
    _modelHelper.initialize();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();
        setState(() {
          _image = image;
        });
        await _classifyImage(File(_image!.path));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking picture: $e')),
        );
      }
    }
  }

  Future<void> _classifyImage(File image) async {
    try {
      List<String> prediction = _modelHelper.predict(image);

      // Navigate to detail page with prediction result
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanResultPage(
                  prediction: prediction[0],
                  accuracy: prediction[1],
                  image: image)));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil mengklasifikasikan gambar')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error classifying image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _modelHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: _cameraController != null &&
                      _cameraController!.value.isInitialized
                  ? CameraPreview(_cameraController!)
                  : const Center(child: CircularProgressIndicator()),
            ),
            Positioned(
              top: 12,
              left: 16,
              right: 0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppAssets.leftRoundedIcon,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 90),
                  Text(
                    "Scan Makanan",
                    style: TypographyStyles.bold(20, ColorStyles.bgScreen),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Card(
                elevation: 0, // Adjust elevation for shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                color: Colors.amber,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    'Arahkan kamera ke makanan untuk menemukan rekomendasi sehat dari Santapan',
                    style: TypographyStyles.bold(14, ColorStyles.bgScreen),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _takePicture,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorStyles.bgScreen,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
