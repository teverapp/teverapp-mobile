import 'package:flutter/material.dart';

class LogoLoader extends StatefulWidget {
  final double height;
  final double width;
  const LogoLoader({super.key, required this.height, required this.width});

  @override
  State<LogoLoader> createState() => _LogoLoaderState();
}

class _LogoLoaderState extends State<LogoLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/logo/splash_logo.png',
            height: widget.height,
            width: widget.width,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Please wait...",
          style: TextStyle(fontSize: 12),
        )
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources.
    super.dispose();
  }
}
