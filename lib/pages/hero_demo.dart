import 'package:flutter/material.dart';


class HeroDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
                _heroElement(context, "first", Colors.red),
              _heroElement(context, "second", Colors.green),
              _heroElement(context, "third", Colors.blue)
            ],
          )
        ),
      ),
    );
  }

  Widget _heroElement(BuildContext context, String tag, Color color){
    return InkWell(
      key: Key(tag),
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => IconPage(tag : tag, color: color),
          transitionDuration: Duration(milliseconds: 800)
        ),);
      },
      child: Hero(
        tag: tag,
        createRectTween: (begin, end) {
          return RectTween(begin: begin, end: end);
        },
        transitionOnUserGestures: true,
        child: Container(
          margin: EdgeInsets.all(5),
          width: 300,
          height: 200,
          color: color,
          child: Icon(Icons.ac_unit, size: 150.0,),
        ),
      ),
    );
  }
}


class IconPage extends StatelessWidget {
  IconPage({Key key, this.tag, this.color}) : super(key : key);
  final String tag;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Hero(

              tag: tag,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: color,
                  child: Container(child: Icon(Icons.ac_unit, size: 128,))),
            ),
          ),
        ),
    );
  }
}
