import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future singleImagePick() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }
}