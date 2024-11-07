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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                      'https://i.pinimg.com/originals/5b/6e/ca/5b6eca63605bea0eeb48db43f77fa0ce.jpg'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
