import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BouncingIconButton extends StatefulWidget {
  @override
  _BouncingIconButton createState() => _BouncingIconButton();

  final double size;
  final IconData iconData;
  final Function onClickAction;

  BouncingIconButton({
    required this.size,
    required this.iconData,
    required this.onClickAction,
  });
}

class _BouncingIconButton extends State<BouncingIconButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () {
        widget.onClickAction();
      },
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI(),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  Widget _animatedButtonUI() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 15,
              // changes position of shadow
            ),
          ]),
      child: Center(
        child: Icon(
          widget.iconData,
          size: 35,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}
