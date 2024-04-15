import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';

class ChatPage extends StatefulWidget {
  final String nameReciver;
  final String receiverUserID;
  final String senderUserID;

  const ChatPage(
      {super.key,
      required this.nameReciver,
      required this.receiverUserID,
      required this.senderUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading:
              MediaQuery.of(context).size.width < widthSize,
          title: Text(
            widget.nameReciver,
            style: GoogleFonts.plusJakartaSans(
              color: backgroundColor,
              fontSize: size24(context),
              fontWeight: FontWeight.w500,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return SizedBox(
      key: Key('messageList'),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: TextField(
              key: Key('msgField'),
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(right: 20),
          child: IconButton(
            key: Key('sendMessage'),
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 30,
              color: backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
