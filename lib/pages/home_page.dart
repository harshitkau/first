import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonradius = 100;
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _stariconanimationcontroller;

  @override
  void initState() {
    super.initState();
    _stariconanimationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _stariconanimationcontroller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pagebackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circulerAnimationbutton(),
                _staricon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pagebackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubicEmphasized,
      builder: (_context, _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circulerAnimationbutton() {
    return Center(
      child: GestureDetector(
          onTap: () {
            setState(() {
              _buttonradius += _buttonradius == 200 ? -100 : 100;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            height: _buttonradius,
            width: _buttonradius,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(_buttonradius),
            ),
            child: const Center(
              child: Text(
                "Basic!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )),
    );
  }

  Widget _staricon() {
    return AnimatedBuilder(
      animation: _stariconanimationcontroller!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _stariconanimationcontroller!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
