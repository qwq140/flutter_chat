import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chat_bubble.dart';

class Chat extends StatelessWidget {
  Chat({Key? key, required this.username, this.profileUrl, required this.text, required this.isMine,}) : super(key: key);

  final String username;
  String? profileUrl;
  final String text;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return isMine ? _buildMyMsg(deviceWidth) : _buildOtherMsg(deviceWidth);
  }

  Widget _buildMyMsg(double deviceWidth) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomPaint(
          painter:
              ChatBubble(color: Colors.orange, alignment: Alignment.topRight),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 26, top: 12, bottom: 12),
            constraints: BoxConstraints(
              maxWidth: deviceWidth * 0.6,
            ),
            child: Text(text, style: Spoqa.black_s14_w400,),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherMsg(double deviceWidth) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 40,
            height: 40,
            color: Colors.purple,
            child: profileUrl == null ? null : Image.network(profileUrl!, fit: BoxFit.cover,),
          ),
        ),
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username),
            CustomPaint(
              painter: ChatBubble(color: Colors.grey, alignment: Alignment.topLeft),
              child: Container(
                padding: const EdgeInsets.only(left : 26, right: 16, top: 12, bottom: 12),
                constraints: BoxConstraints(
                  maxWidth: deviceWidth * 0.6,
                ),
                child: Text(text, style: Spoqa.white_s14_w400),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
