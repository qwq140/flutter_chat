import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';

class ChatroomListItem extends StatelessWidget {
  const ChatroomListItem({Key? key, required this.item, required this.onTap}) : super(key: key);

  final ChatroomModel item;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              color: Colors.purple,
              child: item.imageUrl == null
                  ? null
                  : Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Spoqa.black_s18_w500,
              ),
              Text(
                item.intro ?? "",
                style: Spoqa.grey_s14_w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
