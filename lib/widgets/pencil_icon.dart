import 'package:flutter/material.dart';

class PencilIcon extends StatelessWidget {
  const PencilIcon({
    super.key, required this.icon,
  });

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () => {},
      iconSize: 50,
      );
  }
}