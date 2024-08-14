import 'dart:convert';
import 'dart:io';

Future<String> convertImageToBase64(File image) async {
  if (image.path.isEmpty) return '';

  // Convert the image to base64
  final bytes = await image!.readAsBytes();
  return base64Encode(bytes);
}

Future<File> convertBase64ToImage(String image) async {
  if (image.isEmpty) return File('');

  // Convert the image to base64
  final decodedImage = base64Decode(image);
  return File.fromRawPath(decodedImage);
}
