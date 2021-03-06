import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut);
    _animation =
        Tween<double>(begin: 0.0, end: 2 * math.pi).animate(_curvedAnimation)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation'),
      ),
      body: Transform.rotate(
        angle: _animation.value,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: Image.asset('assets/stethoscope.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
