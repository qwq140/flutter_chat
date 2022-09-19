import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chat_model.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chat.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chat_bubble.dart';
import 'package:flutter_chat/app/state/chat_provider.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {
  const ChatroomScreen({Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userKey = context.read<UserProvider>().userModel!.userKey;
    List<ChatModel> chatList = context.watch<ChatProvider>().chatList;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              reverse: true,
              itemBuilder: (context, index) {
                return Chat(text: chatList[index].msg, isMine: chatList[index].userKey == userKey,);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: chatList.length,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: '메세지를 입력하세요',
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String text = _textEditingController.text;
                    context.read<ChatProvider>().sendChat(userKey, text);
                    _textEditingController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
