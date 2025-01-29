import 'dart:math';
import 'package:flutter/material.dart';

class LdsLoadingSpinner extends StatefulWidget {
  const LdsLoadingSpinner({super.key});

  @override
  State<LdsLoadingSpinner> createState() => _LdsLoadingSpinnerState();
}

class _LdsLoadingSpinnerState extends State<LdsLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1, milliseconds: 200),
    )..repeat();
  }

  double _calculateScale(int index) {
    // Cycle through 12 dots
    final double progress = (_controller.value + index / 12) % 1.0;
    if (progress < 0.5) {
      // Scale up to 1.5
      return 1.0 + progress * 2;
    } else {
      // Scale back to 1.0
      return 1.5 - (progress - 0.5) * 2;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: List.generate(12, (index) {
          final double angle = (pi / 6) * index;
          return Transform.translate(
            offset: Offset(
              36.8 * cos(angle) + 36.8,
              36.8 * sin(angle) + 36.8,
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _calculateScale(index),
                  child: child,
                );
              },
              child: Container(
                width: 6.4,
                height: 6.4,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
