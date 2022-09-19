import 'package:flutter/material.dart';
import 'package:flutter_chat/app/data/chat_model.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chat.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chat_bubble.dart';
import 'package:flutter_chat/app/state/chat_provider.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {

  const ChatroomScreen({Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  late final TextEditingController _textEditingController;
  late Future myFuture;

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
    UserModel userModel = context.read<UserProvider>().userModel!;
    List<ChatModel> chatList = context.watch<ChatProvider>().chatList;
    ChatroomModel? chatroomModel = context.read<ChatProvider>().chatroomModel;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(chatroomModel?.title ?? ""),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: context.read<ChatProvider>().getOldChatList,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Chat(
                        username: chatList[index].username,
                        profileUrl: chatList[index].profileUrl,
                        text: chatList[index].msg,
                        isMine: chatList[index].userKey == userModel.userKey,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: chatList.length,
                  ),
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
                        context.read<ChatProvider>().sendChat(username: userModel.username, msg: text, userKey: userModel.userKey, profileUrl: userModel.profileUrl);
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
        ),
      ),
    );
  }
}
