import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> convertImageToBase64(File image) async {
  if (image.path.isEmpty) return '';

  // Convert the image to base64
  final bytes = await image.readAsBytes();
  return base64Encode(bytes);
}

Future<File> convertBase64ToImage(String image) async {
  if (image.isEmpty) return File('');

  // Convert the image to base64
  final decodedBytes = base64Decode(image);

  // Get the temporary directory of the device
  final directory = await getTemporaryDirectory();

  // Create a path for the image file
  final filePath =
      '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

  // Write the bytes to a file
  return File(filePath).writeAsBytes(decodedBytes);
}
