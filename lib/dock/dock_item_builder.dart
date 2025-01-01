import 'package:flutter/material.dart';

Widget defaultDockItemBuilder(IconData icon, double size) {
  return Container(
    constraints: BoxConstraints.tight(Size.square(size)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[icon.hashCode % Colors.primaries.length],
    ),
    child: Center(
      child: Icon(icon, color: Colors.white, size: size * 0.6),
    ),
  );
}
