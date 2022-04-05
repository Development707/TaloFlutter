import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';

import '../../../models/contacts.dart';
import 'contacts_item.dart';

class ContactsBody extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final List<Contacts> contacts;
  const ContactsBody({
    Key? key,
    required this.selected,
    required this.callback,
    required this.pageController,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<TypeStatus, List<Contacts>> menu = {
      TypeStatus.FRIEND: [],
      TypeStatus.FOLLOWER: [],
      TypeStatus.FOLLOWING: [],
      TypeStatus.NOT_FRIEND: [],
    };
    for (var contact in contacts) {
      if (contact.status == TypeStatus.FRIEND) {
        menu[TypeStatus.FRIEND]?.add(contact);
      }
      if (contact.status == TypeStatus.FOLLOWER) {
        menu[TypeStatus.FOLLOWER]?.add(contact);
      }
      if (contact.status == TypeStatus.FOLLOWING) {
        menu[TypeStatus.FOLLOWING]?.add(contact);
      }
      if (contact.status == TypeStatus.NOT_FRIEND) {
        menu[TypeStatus.NOT_FRIEND]?.add(contact);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: PageView(
        controller: pageController,
        onPageChanged: (index) => callback(index),
        children: [
          ListView.builder(
            itemBuilder: ((context, index) => ConstactsItem(
                contacts: menu[TypeStatus.values.elementAt(selected)]![index])),
            itemCount: menu[TypeStatus.values.elementAt(selected)]!.length,
          )
        ],
      ),
    );
  }
}
