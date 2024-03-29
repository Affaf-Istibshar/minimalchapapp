
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatapp/components/message_bubble.dart';
import 'package:minimalchatapp/components/my_textfield.dart';
import 'package:minimalchatapp/services/auth/auth_services.dart';
import 'package:minimalchatapp/services/chat/chat_services.dart';
class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiveID;

   ChatPage({super.key,
  required this.receiveEmail,
  required this.receiveID
  });
final TextEditingController _messageController = TextEditingController();

 //auth and chat services
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();
  // send messages
  void sendMessage() async {
    //if there is something inside the textfield
    if(_messageController.text.isNotEmpty){
      //send message
      await _chatServices.sendMessage(
          receiveID, _messageController.text);
      //clear text controller
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  AppBar(
        title: Text(receiveEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          //user input
          _buildUserInput()
        ],
      ),
    );
  }
  Widget _buildMessageList(){
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatServices.getMessages(receiveID, senderID),
        builder: (context, snapshot){
      //errors
         if(snapshot.hasError){
           return Text('Error');
         }
       //loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading..');
          }
        // return list view
          return ListView(
            children: snapshot.data!.docs.map((doc) =>
            _buildMessageItem(doc)).toList(),
            );
        }
        );
  }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // current user
bool isCurrentUser = data['senderID'] == _authServices.getCurrentUser()!.uid;
    //current user message alignment right
var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
          isCurrentUser  ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
     ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,)
        ],
      ),
    );
  }
  //build message input
    Widget _buildUserInput(){
    return Padding(padding: EdgeInsets.only(bottom: 50),
    child: Row(
      children: [
        //textfield should take up most of the space
        Expanded(child:
        MyTextField(
          controller: _messageController,
          hintText: "Type message here!",
          obscureText: false,
        )
        ),
        //send button
        Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(right: 25) ,
          child: IconButton(onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward,
              color: Colors.white,
              )),
        ),
      ],
    ),
    );
    }
}
