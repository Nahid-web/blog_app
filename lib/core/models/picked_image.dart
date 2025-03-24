import 'package:image_picker/image_picker.dart';

class PickedImage {
  final dynamic file; // XFile for web, File for mobile
  final String path;

  PickedImage({required this.file, required this.path});

  bool get isWeb => file is XFile;
}
