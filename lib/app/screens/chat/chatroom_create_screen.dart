import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';
import 'package:go_router/go_router.dart';

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
              onPressed: () {},
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
              Spacer(
                flex: 100,
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        color: Colors.purple,
                      ),
                    ),
                    Positioned(
                      right: -10,
                      bottom: 0,
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
                    )
                  ],
                ),
              ),
              Spacer(
                flex: 150,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '채팅방 이름',
                  labelStyle: Spoqa.grey_s14_w400,
                  floatingLabelStyle: Spoqa.black_s14_w400,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                cursorColor: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _introController,
                decoration: InputDecoration(
                  labelText: '채팅방 소개',
                  labelStyle: Spoqa.grey_s14_w400,
                  floatingLabelStyle: Spoqa.black_s14_w400,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                cursorColor: Colors.black,
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
