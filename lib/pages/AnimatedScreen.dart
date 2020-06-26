import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  final bool selected;
  final Key key;
  final Color color;
  AnimatedScreen({this.key, this.selected, this.color}) : super(key : key);
  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController, sizeAnimationController;
  Animation borderAnimation, colorAnimation, sizeAnimation;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
//    borderAnimation = BorderRadiusTween(begin: BorderRadius.circular(29), end:  BorderRadius.circular(0)).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    colorAnimation = ColorTween(begin: widget.color.withOpacity(.5), end: widget.color).animate(CurvedAnimation(parent: animationController, curve: Interval(0.8, 1 ,curve : Curves.easeIn), reverseCurve: Curves.easeOut));
    sizeAnimation = Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(parent: animationController, curve: Interval(0.1, 1 ,curve : Curves.easeIn), reverseCurve: Curves.easeOut));

  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isSelected = false;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        widget.selected ? animationController.forward() : animationController.reverse();
        return Center(
            child: Container(
              margin: EdgeInsets.all(5),
              height: sizeAnimation.value * 200,
              width: sizeAnimation.value * width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: colorAnimation.value,
              ),

            ),
        );
      },
    );
  }
}
