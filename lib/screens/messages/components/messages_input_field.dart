import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../../../models/conversation.dart';
import '../../../plugin/constants.dart';
import '../../../store/message_store.dart';
import 'message_files.dart';

class MessagesInputField extends StatefulWidget {
  const MessagesInputField({Key? key, this.conversation}) : super(key: key);
  final Conversation? conversation;

  @override
  State<MessagesInputField> createState() => _MessagesInputFieldState();
}

class _MessagesInputFieldState extends State<MessagesInputField> {
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  final _ctrlText = TextEditingController();
  final store = MessageStore();

  void sendText() {
    if (_ctrlText.text.isNotEmpty) {
      store
          .sendMessage(widget.conversation?.id, _ctrlText.text)
          .then((value) => setState(() => _ctrlText.text = ""));
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() => showEmoji = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          ]),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 4),
              child: WillPopScope(
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 0.75),
                          height: 50,
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(children: [
                            InkWell(
                              onTap: () => setState(() {
                                focusNode.unfocus();
                                showEmoji = !showEmoji;
                              }),
                              child: Icon(
                                Icons.sentiment_satisfied_alt_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding / 4),
                            Expanded(
                              child: TextField(
                                focusNode: focusNode,
                                controller: _ctrlText,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                    hintText: "Type message",
                                    border: InputBorder.none),
                              ),
                            ),
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => messageFile(context)),
                              child: Icon(
                                Icons.attach_file,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding / 4),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                          ]),
                        )),
                    IconButton(
                      icon: const Icon(Icons.send, color: kPrimaryColor),
                      onPressed: () {
                        sendText();
                      },
                    ),
                  ],
                ),
                onWillPop: () {
                  if (showEmoji) {
                    setState(() => showEmoji = false);
                  } else {
                    Navigator.pop(context);
                  }
                  return Future.value(false);
                },
              ),
            ),
            showEmoji ? emojiField() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget emojiField() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (Category category, Emoji emoji) {
          setState(() => _ctrlText.text = _ctrlText.text + emoji.emoji);
        },
      ),
    );
  }
}
