import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chatroom_list_item.dart';
import 'package:flutter_chat/app/state/chatroom_list_provider.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // late Future myFuture;

  @override
  void initState() {
    // TODO: implement initState
    // myFuture = context.read<ChatroomListProvider>().getChatroomList('userKey');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              context.go('/chatroom/create');
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      // body: FutureBuilder<void>(
      //     future: myFuture,
      //     builder: (context, snapshot) {
      //       return snapshot.connectionState == ConnectionState.done
      //           ? _list()
      //           : Center(
      //               child: CircularProgressIndicator(),
      //             );
      //     }),
      body: StreamBuilder<List<ChatroomModel>>(
        stream: context
            .read<ChatroomListProvider>()
            .chatroomStream,
        builder: (context, snapshot) {
          List<ChatroomModel> chatroomList = [];
          if (snapshot.hasData) {
            chatroomList.addAll(snapshot.data!);
            return _list(chatroomList);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _showDialog(ChatroomModel chatroom, String userKey) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.purple,
                        child: chatroom.imageUrl == null
                            ? null
                            : Image.network(
                          chatroom.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(chatroom.title),
                  ],
                ),
                const SizedBox(height: 10),
                Text(chatroom.intro ?? "소개 글이 없습니다."),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<ChatroomListProvider>()
                      .joinChatroom(userKey, chatroom.chatroomKey);
                  context.go('/chatroom/${chatroom.chatroomKey}');
                },
                child: Text('참여'),
              )
            ],
          ),
    );
  }

  void goChatroom(ChatroomModel chatroomModel, String myUserKey) {
    if (chatroomModel.userKeys.contains(myUserKey)) {
      context.go('/chatroom/${chatroomModel.chatroomKey}');
    } else {
      _showDialog(chatroomModel, myUserKey);
    }
  }

  Widget _list(List<ChatroomModel> list) {
    String userKey = context.read<UserProvider>().userModel!.userKey;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      itemBuilder: (context, index) {
        return ChatroomListItem(
          item: list[index],
          onTap: () => goChatroom(list[index], userKey),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: list.length,
    );
  }
}
