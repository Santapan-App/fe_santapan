import 'package:flutter/material.dart';

import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/core/typography_styles.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // File? _image;
  // final ImagePicker _picker = ImagePicker();

  // @override

  // void initState() {
  //   super.initState();
  //   _openCamera();
  // }

  // Future<void> _openCamera() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   } else {
  //     Navigator.of(context).pop();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Makanan',
          style: TypographyStyles.bold(20, ColorStyles.black),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
