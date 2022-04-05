import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../models/contacts.dart';
import '../../plugin/constants.dart';
import '../../store/profile_store.dart';
import 'components/contacts_body.dart';
import 'components/contacts_filter.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  var selected = 0;
  final pageController = PageController();
  final store = ProfileStore();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => getContactsIntoPhone());
    return FutureBuilder<List<Contacts>>(
        future: store.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(
                Duration.zero, () => Navigator.of(context).pushNamed("/chat"));
          }
          if (snapshot.hasData) {
            return buildContacts(snapshot.data ?? []);
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  Column buildContacts(List<Contacts> _contacts) {
    return Column(children: [
      ContactsFillter(
        selected: selected,
        callback: (int index) {
          setState(() {
            selected = index;
          });
          pageController.jumpToPage(index);
        },
      ),
      Expanded(
          child: ContactsBody(
        selected: selected,
        callback: (int index) {
          setState(() {
            selected = index;
          });
        },
        pageController: pageController,
        contacts: _contacts,
      ))
    ]);
  }

  Future<void> getContactsIntoPhone() async {
    if (!kIsWeb && await FlutterContacts.requestPermission()) {
      var _contacts = await FlutterContacts.getContacts();
      await store.asyncContacts(_contacts);
    }
  }
}
