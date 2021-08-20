import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvchat/helperfunctions/sharedpref_helper.dart';
import 'package:tvchat/models/ChatMessage.dart';
import 'package:tvchat/services/database.dart';
import 'chat_input_field.dart';

import 'message.dart';

class Body extends StatefulWidget {
  Body(
      this.broadCastingOffice,
      );
  final String broadCastingOffice;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? myName, myProfilePic, myUserName, myEmail;
  Stream<QuerySnapshot>? _chats;
  getMyInfoFromSharedPreference() async {
    myName = SharedPreferenceHelper().getDisplayName().toString();
    myProfilePic = SharedPreferenceHelper().getUserProfileUrl().toString();
    myEmail = SharedPreferenceHelper().getUserEmail().toString();
    myUserName = SharedPreferenceHelper().getUserName().toString();
  }


  getChats() async {
    setState((){
      _chats = DatabaseMethods().getChats(widget.broadCastingOffice);
    });
  }

  @override
  void initState() {
    getMyInfoFromSharedPreference();
    getChats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _chats,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    ChatMessage data = snapshot.data!.docs[index]
                      as ChatMessage;
                    return Message(message: data,);
                  },
                );
              },
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}



