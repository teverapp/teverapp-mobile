import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  final String imageUrl;
  final double imageHeight;
  final double imageWidth;
  const RotateImage({
    super.key,
    required this.imageHeight,
    required this.imageUrl,
    required this.imageWidth,
  });

  @override
  State<RotateImage> createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.141592653589793,
          child: child,
        );
      },
      child: Image.asset(
        widget.imageUrl,
        height: widget.imageHeight,
        width: widget.imageWidth,
      ),
    );
    ;
  }
}
