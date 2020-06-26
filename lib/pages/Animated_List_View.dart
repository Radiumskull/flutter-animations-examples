import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutteranimations/pages/AnimatedScreen.dart';


class AnimatedListView extends StatefulWidget{
  @override
  _AnimatedListViewState createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> with SingleTickerProviderStateMixin {
  int selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        selected = index;
                      });
                    },
                    onDoubleTap: (){
                      setState(() {
                        selected = null;
                      });
                    },
                    child: AnimatedScreen(
                      key : Key(index.toString()),
                      selected : index == selected,
                      color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1),
                    ),
                  );
                },),
      ),
    );
  }
}
