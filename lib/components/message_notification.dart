import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MessageNotification extends StatelessWidget {
  final VoidCallback onReplay;
  final String title;
  final String subtitle;

  const MessageNotification({Key key, this.onReplay, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                  child: Image.asset('lib/assets/medical-png-icon-4.jpg'))),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                if (onReplay != null) onReplay();
              }),
        ),
      ),
    );
  }
}
