import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 20,
                  color: Colors.black,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: 10,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(width: 10,),
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
                    print(text);
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
