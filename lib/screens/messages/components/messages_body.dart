import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';

import '../../../models/message.dart';
import '../../../models/user.dart';
import '../../../store/profile_store.dart';
import 'messages_input_field.dart';
import 'messages_item.dart';

class MessagesBody extends StatelessWidget {
  MessagesBody({Key? key, this.message}) : super(key: key);
  final Message? message;
  final ProfileStore store = ProfileStore();

  @override
  Widget build(BuildContext context) {
    return message != null
        ? FutureBuilder<User>(
            future: store.getProFile(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Future.delayed(Duration.zero,
                    () => Navigator.of(context).pushNamed("/chat"));
              }
              if (snapshot.hasData) {
                return buildBody(snapshot.data);
              } else {
                return const LinearProgressIndicator(color: kPrimaryColor);
              }
            },
          )
        : const LinearProgressIndicator(color: kPrimaryColor);
  }

  Column buildBody(User? user) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: message!.data.length,
              itemBuilder: (context, index) => MessageItem(
                  message: message!.data[index],
                  isSender: message!.data[index].user.id == user!.id),
            )),
        const MessagesInputField(),
      ],
    );
  }
}
