import 'dart:ui';

import 'package:flutter/material.dart';


class HeroDemo2 extends StatelessWidget {
  AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BuyButton(),
      body: Container(),
    );
  }
}

class BuyButton extends StatefulWidget {
  @override
  _BuyButtonState createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> with SingleTickerProviderStateMixin{
  String _buttonText = "Buy Now";
  AnimationController _controller;
  Animation _roundAnimation, _widthAnimation, _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: 500),vsync: this)..addListener(() {
      setState(() {
      });
    });
    _roundAnimation = BorderRadiusTween(begin: BorderRadius.circular(29), end: BorderRadius.circular(10)).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _widthAnimation = Tween<double>(begin: 40.0, end: 200.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.45, 1, curve: Curves.linear), reverseCurve: Curves.linear));
    _opacityAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.6, curve: Curves.linear)));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: (){
            _controller.reverse().whenComplete(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionPage(controller: _controller),));
            });
        },

        child: Hero(
          tag: "buy",
          createRectTween: (begin, end) => CircularRectTween(begin: begin, end: end),
          flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
              ){
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue),
              );
          },
          child: Container(
            height: 45,
            width: _widthAnimation.value,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: _roundAnimation.value,),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Opacity(opacity: _opacityAnimation.value ,child: Text(_widthAnimation.value >= 100 ? _buttonText : "", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18, letterSpacing: 2), textAlign: TextAlign.center,)),
          ),
        ),
      ),
    );
  }
}


class TransactionPage extends StatelessWidget {
  final AnimationController controller;
  TransactionPage({Key key,this.controller}) : super(key : key);
  static RectTween _createRectTween(Rect begin, Rect end) {
    return CircularRectTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          controller.forward();
          Navigator.of(context).pop();
        },
        child: Material(
          child: Hero(
            createRectTween: _createRectTween,
            tag: "buy",
            child: Container(
              color: Colors.blue,
                child: Center(child: Text("Screen 2"))),
          ),
        ),
      )
    );
  }
}

class CircularRectTween extends RectTween {
  CircularRectTween({Rect begin, Rect end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final double width = lerpDouble(begin.width, end.width, t);
      print(width);
//    double startWidthCenter = begin.left + (begin.width / 2);
//    double startHeightCenter = begin.top + (begin.height / 2);
    return Rect.fromCircle(center: begin.bottomCenter.translate(0, -40), radius: width * 1.8);
  }
}

