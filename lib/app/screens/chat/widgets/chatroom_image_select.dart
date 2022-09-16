import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_chat/app/state/chatroom_create_provider.dart';
import 'package:flutter_chat/app/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatroomImageSelect extends StatelessWidget {
  const ChatroomImageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('fdsfuu93939');
    Uint8List? img = context.watch<ChatroomCreateProvider>().img;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: Colors.purple
            ),
            child: img == null ? Container() : Image.memory(img,fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: -10,
          bottom: 0,
          child: GestureDetector(
            onTap: () async {
              XFile? file = await ImageUtils.singleImagePick();
              if(file == null) return;
              context.read<ChatroomCreateProvider>().img = await file.readAsBytes();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.camera_alt,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }
}
