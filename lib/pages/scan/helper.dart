import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class Helper {
  late Interpreter _interpreter;
  late List<String> _labels;

  Future<void> initialize() async {
    await loadLabels('assets/model/labels.txt');
    await loadModel('model/tf_lite_model.tflite');
  }

  /// Load model with options
  Future<void> loadModel(String modelPath) async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
      print('Model and labels loaded successfully.');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  /// Load labels from asset file
  Future<void> loadLabels(String labelPath) async {
    final labelData = await rootBundle.loadString(labelPath);
    _labels = labelData.split('\n');
  }

  /// Preprocess image: resize, normalize, and format input
  List<List<List<double>>> preprocessImage(File imageFile, {int inputSize = 224}) {
    final imageBytes = imageFile.readAsBytesSync();
    final decodedImage = img.decodeImage(imageBytes);
    final resizedImage = img.copyResize(decodedImage!, width: inputSize, height: inputSize);

    List<List<List<double>>> normalizedImage = List.generate(
      inputSize,
      (y) => List.generate(
        inputSize,
        (x) => [
          resizedImage.getPixel(x, y).r / 1,  // Normalize red channel
          resizedImage.getPixel(x, y).g / 1,  // Normalize green channel
          resizedImage.getPixel(x, y).b / 1,  // Normalize blue channel
        ],
      ),
    );

    return normalizedImage;
  }

  /// Perform inference (example: single prediction)
  List<String> predict(File imageFile) {
    final input = preprocessImage(imageFile);
    var output = List.generate(1, (_) => List.filled(_labels.length, 0.0));
    _interpreter.run(input, output);
    int predictedIndex = output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));
    return [_labels[predictedIndex], output[0][predictedIndex].toStringAsFixed(2)];
  }

  void close() {
    _interpreter.close();
  }
}
