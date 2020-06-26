import 'dart:math';

import 'package:flutter/material.dart';

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(animationController : animationController);
  }
}

class RadialAnimation extends StatelessWidget {
  AnimationController animationController;
  RadialAnimation({Key key, this.animationController}) :
        scale = Tween<double>(begin: 1.2, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)),
        translation = Tween<double>(begin: 0.0, end: 100.0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.02, 1, curve : Curves.elasticOut))),
//        rotation = Tween<double>(begin: 180.0, end: 360.0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.7, curve: Curves.easeIn))),
        super(key : key);

  final Animation<double> scale;
  final Animation<double> translation;
//  final Animation<double> rotation;


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildButton(180, color: Colors.pink, icon: Icons.access_alarms, onClick: _close),
            _buildButton(225, color: Colors.deepOrange, icon: Icons.access_alarms, onClick: _close),
            _buildButton(270, color: Colors.pink, icon: Icons.access_alarms, onClick: _close),
            Transform.scale(
              scale: scale.value - 1,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: _close,
                child: Icon(Icons.close,),
              ),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                onPressed: _open,
                child: Icon(Icons.open_with),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton(double angle, {Color color, IconData icon, Function onClick}){
    final double rad = angle * (pi / 180);
    return Transform(
      transform: Matrix4.identity()..translate(translation.value * cos(rad), translation.value * sin(rad)),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed : onClick,
      ),
    );
  }

  _open(){
    animationController.forward();
  }

  _close(){
    animationController.reverse();
  }

}

class BuildButton extends StatelessWidget {
  IconData icon;
  double angle;
  Color color;
  Animation translation;
  BuildButton({Key key, this.angle, this.icon, this.color, this.translation}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final double rad = angle * (pi / 180);
    return Transform(
      transform: Matrix4.identity()..translate(translation.value * cos(rad), translation.value * sin(rad)),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed : () {
          print(color);
        },
      ),
    );
  }
}





class RadialSelectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RadialMenu(),
        ),
      )
    );
  }
}

