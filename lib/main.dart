import 'package:flutter/material.dart';

void main() {
  runApp(
   MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Злобин Никита Сергеевич',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black87,
          leading: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 40,
          ),
        ),
        body: Container(
          color: Colors.amber,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Image.network(
                'https://avatars.mds.yandex.net/i?id=584e8dbf4fb40ea41f840c34d92960e8_l-5427846-images-thumbs&n=13'
            ),
          ),
        ),
      ),
    ),
  );
}