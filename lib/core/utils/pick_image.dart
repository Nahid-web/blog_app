import 'dart:io';


import 'package:image_picker/image_picker.dart';

import '../models/picked_image.dart';

Future<PickedImage?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      // Create a File from XFile path for both web and mobile
      final file = File(xFile.path);
      return PickedImage(file: file, path: xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
