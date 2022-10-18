import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  int userid;
  String text;
  AnimationController animationController;

  ChatMessage(this.userid, this.text, this.animationController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: userid == 1 ? _myMenssage() : _notMyMenssage(),
        ),
      ),
    );
  }

  _myMenssage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 5,
        ),
        decoration: const BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }

  _notMyMenssage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 50,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primary),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}


// if (mensajes.messages[i].useridfrom ==
//     //                                             mensajes.members![0].id)