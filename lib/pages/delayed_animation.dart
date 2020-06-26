import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> with SingleTickerProviderStateMixin{
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.3, 1 , curve : Curves.fastOutSlowIn)));
    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.6, 1 , curve : Curves.fastOutSlowIn)));


    animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => Transform(
                  transform: Matrix4.translationValues(animation.value * width , 0.0, 0.0),
                  child: InkWell(
                    onTap: (){
                      print("Tapped");
                      animationController.reverse().whenComplete(() => animationController.forward());
                    },
                    child: Container(
                      height: height/3.1,
                      color: Colors.blue,
                      child: Center(
                        child: Container(
                          child: Text("Hello World"),
                        ),
                      ),
                    ),
                  ),
                )
            ),
            AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value * width , 0.0, 0.0),
                  child: Container(
                    height: height/3.1,
                    color: Colors.red,
                    child: Center(
                      child: Container(
                        child: Text("Hello World"),
                      ),
                    ),
                  ),
                )
            ),
            AnimatedBuilder(
                animation: animationController,
                builder: (context, child) => Transform(
                  transform: Matrix4.translationValues(muchDelayedAnimation.value * width , 0.0, 0.0),
                  child: Container(
                    height: height/3.1,
                    color: Colors.green,
                    child: Center(
                      child: Container(
                        child: Text("Hello World"),
                      ),
                    ),
                  ),
                )
            ),
          ],
        )
      ),
    );
  }
}
