import 'package:flutter/material.dart';

class ExpandableCardContainer extends StatefulWidget {
  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;
  final VoidCallback onToggle;

  const ExpandableCardContainer({
    super.key,
    required this.isExpanded,
    required this.collapsedChild,
    required this.expandedChild,
    required this.onToggle,
  });

  @override
  State<ExpandableCardContainer> createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    if (widget.isExpanded) {
      _controller.value = 1.0; // Set initial value instead of animating
    }
  }

  @override
  void didUpdateWidget(covariant ExpandableCardContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.animateTo(1.0, curve: Curves.easeOutQuad);
      } else {
        _controller.animateTo(0.0, curve: Curves.easeInQuad);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: widget.onToggle,
          child: Column(
            children: [
              widget.collapsedChild,
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRect(
                    child: Align(
                      heightFactor: _controller.value,
                      child: Opacity(
                        opacity: _controller.value,
                        child: widget.expandedChild,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
