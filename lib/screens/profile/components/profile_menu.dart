import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            const SizedBox(width: 20),
            Expanded(
                child:
                    Text(text, style: Theme.of(context).textTheme.bodyText1)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
