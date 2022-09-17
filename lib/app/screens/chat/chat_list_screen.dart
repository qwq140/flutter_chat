import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/data/chatroom_model.dart';
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

  late Future myFuture;

  @override
  void initState() {
    // TODO: implement initState
    myFuture = context.read<ChatroomListProvider>().getChatroomList('userKey');
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
      body: FutureBuilder<void>(
        future : myFuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done ? _list() : Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
  
  void goChatroom(ChatroomModel chatroomModel, String myUserKey) {
    if(chatroomModel.userKeys.contains(myUserKey)){
      context.go('/chatroom/${chatroomModel.chatroomKey}');
    }
  }

  Widget _list() {
    return Builder(
      builder: (context) {
        List<ChatroomModel> list = context.read<ChatroomListProvider>().chatroomList;
        String userKey = context.read<UserProvider>().userModel!.userKey;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                goChatroom(list[index], userKey);
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.purple,
                      child: list[index].imageUrl == null ? null : Image.network(list[index].imageUrl!, fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list[index].title, style: Spoqa.black_s18_w500,),
                      Text(list[index].intro ?? "", style: Spoqa.grey_s14_w400,),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: list.length,
        );
      }
    );
  }
}
