import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/screens/group/components/group_button.dart';
import 'package:flutter_mobile_chatapp_v4_2/screens/group/components/group_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/contacts.dart';
import '../../plugin/constants.dart';
import '../../store/conversation_store.dart';
import '../../store/profile_store.dart';
import 'components/group_avatar.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final List<bool> selectedList = [];
  final List<Contacts> contactsSelectedList = [];
  final ConversationStore store = ConversationStore();

  @override
  Widget build(BuildContext context) {
    final store = ProfileStore();

    return Scaffold(
        appBar: buildAppBar(),
        body: FutureBuilder<List<Contacts>>(
            future: store.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Future.delayed(Duration.zero,
                    () => Navigator.of(context).pushNamed("/chat"));
              }
              if (snapshot.hasData) {
                List<Contacts> contacts = snapshot.data ?? [];
                for (var _ in contacts) {
                  selectedList.add(false);
                }
                return Stack(children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: contactsSelectedList.isNotEmpty ? 30 : 0),
                      child: buildBody(contacts)),
                  buildNavbar(contacts),
                ]);
              } else {
                return const LinearProgressIndicator(color: kPrimaryColor);
              }
            }));
  }

  Widget buildNavbar(List<Contacts> _contacts) {
    return contactsSelectedList.isNotEmpty
        ? Column(children: [
            Container(
              height: 80,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: contactsSelectedList.length,
                  itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        setState(() {
                          var i = _contacts.indexWhere((con) =>
                              con.id == contactsSelectedList[index].id);
                          selectedList[i] = false;
                          contactsSelectedList.removeAt(index);
                        });
                      },
                      child:
                          GroupAvatar(contacts: contactsSelectedList[index]))),
            ),
            Divider(thickness: 1)
          ])
        : Container();
  }

  ListView buildBody(List<Contacts> _contacts) {
    return ListView.builder(
      itemCount: _contacts.length + 1,
      itemBuilder: (_, index) {
        if (index == 0) {
          return InkWell(
            onTap: () => openDialogSendRequest(),
            child:
                const GroupButton(name: "New Contact", icon: Icons.person_add),
          );
        }
        return InkWell(
          onTap: () {
            if (selectedList[index - 1]) {
              setState(() {
                selectedList[index - 1] = false;
                contactsSelectedList.removeWhere(
                    (element) => element.id == _contacts[index - 1].id);
              });
            } else {
              setState(() {
                if (_contacts[index - 1].isExists) {
                  selectedList[index - 1] = true;
                  contactsSelectedList.add(_contacts[index - 1]);
                } else {
                  Fluttertoast.showToast(
                      msg: "User hasn't used Talo",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: kPrimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
            }
          },
          child: GroupItem(
              contact: _contacts[index - 1], selected: selectedList[index - 1]),
        );
      },
    );
  }

  Future<void> openDialogSendRequest() {
    var _requestController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Send Request Friend"),
              content: TextField(
                autofocus: true,
                controller: _requestController,
                decoration: InputDecoration(hintText: "Enter phone or mail"),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_requestController.text.length > 5) {
                      await store.sendRequest(_requestController.text);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("SEND"),
                )
              ],
            ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Create group chat"),
          Text("10 contacts", style: TextStyle(fontSize: 10)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (contactsSelectedList.length > 1) {
              store
                  .createGroup(contactsSelectedList.map((e) => e.id).toList())
                  .then((_) =>
                      Navigator.of(context).pushReplacementNamed("/chat"));
            } else {
              Fluttertoast.showToast(
                  msg: "Member invalid > 1 member",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          icon: const Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}
