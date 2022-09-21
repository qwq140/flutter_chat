import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chatroom_create_input_field.dart';
import 'package:flutter_chat/app/screens/chat/widgets/chatroom_image_select.dart';
import 'package:flutter_chat/app/state/chatroom_create_provider.dart';
import 'package:flutter_chat/app/state/chatroom_list_provider.dart';
import 'package:flutter_chat/app/state/user_provider.dart';
import 'package:flutter_chat/app/utils/image_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatroomCreateScreen extends StatefulWidget {
  const ChatroomCreateScreen({Key? key}) : super(key: key);

  @override
  State<ChatroomCreateScreen> createState() => _ChatroomCreateScreenState();
}

class _ChatroomCreateScreenState extends State<ChatroomCreateScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _introController;

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController();
    _introController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _introController.dispose();
    super.dispose();
  }

  void _showDialog(String text){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                bool validate = context.read<ChatroomCreateProvider>().validate();
                if (!validate) {
                  _showDialog('채팅방 이름을 입력해주세요');
                  return;
                }
                UserModel userModel = context.read<UserProvider>().userModel!;
                await context.read<ChatroomCreateProvider>().submit(userModel.userKey);
                _showDialog('등록이 완료되었습니다.');
                context.pop();
              },
              child: const Text(
                '등록',
                style: Spoqa.white_s14_w400,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 100,
              ),
              const Align(
                alignment: Alignment.center,
                child: ChatroomImageSelect(),
              ),
              const Spacer(
                flex: 150,
              ),
              ChatroomCreateInputField(
                  controller: _titleController,
                  onChange: (value){
                    context.read<ChatroomCreateProvider>().title = value;
                  },
                  hintText: '채팅방 이름'
              ),
              SizedBox(
                height: 15,
              ),
              ChatroomCreateInputField(
                  controller: _introController,
                  onChange: (value){
                    context.read<ChatroomCreateProvider>().intro = value;
                  },
                  hintText: '채팅방 소개',
              ),
              Spacer(
                flex: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
