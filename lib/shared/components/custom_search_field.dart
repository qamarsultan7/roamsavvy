import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Widget? prefixIcon;
  final bool autofocus;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onFocusChange;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText = "Search...",
    this.onSubmitted,
    this.onClear,
    this.prefixIcon,
    this.autofocus = false,
    this.decoration,
    this.contentPadding,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onFocusChange,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late FocusNode _focusNode;
  bool _isInternalFocusNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _isInternalFocusNode = true;

      if (widget.onFocusChange != null) {
        _focusNode.addListener(() {
          if (_focusNode.hasFocus) {
            widget.onFocusChange?.call();
          }
        });
      }
    } else {
      _focusNode = widget.focusNode!;
    }
  }

  @override
  void dispose() {
    if (_isInternalFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextField(
      keyboardAppearance: theme.brightness,
      controller: widget.controller,
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      style: widget.textStyle,
      decoration:
          widget.decoration ??
          InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon ?? const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.primaryColor.withAlpha(125)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.primaryColor),
            ),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            filled: true,
            fillColor: theme.cardColor,
          ),
      onSubmitted: widget.onSubmitted,
    );
  }
}
