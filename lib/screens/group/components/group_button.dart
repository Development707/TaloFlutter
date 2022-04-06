import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({Key? key, required this.name, required this.icon})
      : super(key: key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: kPrimaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)));
  }
}
