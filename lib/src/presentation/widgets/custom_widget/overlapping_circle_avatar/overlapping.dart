// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class OverLappingCircleAvatarScreen extends StatefulWidget {
  @override
  State<OverLappingCircleAvatarScreen> createState() =>
      _OverLappingCircleAvatarScreenState();
}

class _OverLappingCircleAvatarScreenState
    extends State<OverLappingCircleAvatarScreen> {
  // list containing URL links of images
  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];
  int numImages = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OverLapping'),
        centerTitle: true,
      ),
      // Using circle avatar
      // to create overlap images
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < numImages; i++)
                    Align(
                      //لكى يبعد مسافة وكلهم محطوطين في النص
                      widthFactor: 0.5,
                      // parent circle avatar.
                      // We defined this for better UI
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              i > RandomImages.length - 1
                                  ? RandomImages[0]
                                  : RandomImages[i]),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              // this circle avatar we created add icon
              InkWell(
                onTap: () {
                  numImages++;
                  setState(() {});
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 50,
                  child: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
