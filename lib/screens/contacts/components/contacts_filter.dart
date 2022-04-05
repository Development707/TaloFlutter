import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';

class ContactsFillter extends StatelessWidget {
  final int selected;
  final Function callback;
  const ContactsFillter({
    Key? key,
    required this.selected,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "Friend",
      "Friend request",
      "Suggestions",
      "Not Friend",
    ];
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 5),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => callback(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2,
                  horizontal: kDefaultPadding * 0.75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == index ? kPrimaryColor : Colors.white,
              ),
              child: Text(items[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected == index ? Colors.white : kPrimaryColor,
                  )),
            )),
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemCount: items.length,
      ),
    );
  }
}
