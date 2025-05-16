import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomMainButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double height;
  final double borderHeight;

  const CustomMainButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height = 56.0,
    this.borderHeight = 4.0,
  });

  @override
  State<CustomMainButton> createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    _controller.forward(from: 0);
    await Future.delayed(const Duration(milliseconds: 300));
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.primary;
    final textColor = widget.textColor ?? theme.colorScheme.onPrimary;

    return InkWell(
      onTap: _handleTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    widget.label,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
            .animate(controller: _controller)
            .scale(
              end: const Offset(1.0, 1.0),
              begin: const Offset(0.95, 0.95),
              curve: Curves.easeInOut,
              duration: 400.ms,
            )
            .then(delay: 400.ms),
      ),
    );
  }
}
