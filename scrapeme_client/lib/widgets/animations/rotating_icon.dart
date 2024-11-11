import 'dart:math';

import 'package:flutter/material.dart';

class RotatingIcon extends StatefulWidget {
  const RotatingIcon(
      {super.key,
      this.icon,
      this.size = 20,
      this.color,
      this.duration = const Duration(seconds: 2)});

  final IconData? icon;
  final double size;
  final Color? color;
  final Duration duration;

  @override
  State<RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.rotate(
        angle: _animation.value,
        child: Icon(
          widget.icon ?? Icons.settings,
          size: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}
