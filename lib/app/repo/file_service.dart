import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FileService {
  static Future uploadImage(Uint8List image, String chatroomKey) async {
    var metaData = SettableMetadata(contentType: 'image/jpeg');

    String formatDate = DateFormat('yyyyMMddHHmm').format(DateTime.now());

    Reference ref = FirebaseStorage.instance.ref('/images/$chatroomKey/$formatDate.jpg');

    await ref.putData(image, metaData);

    return await ref.getDownloadURL();
  }
}