import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final String label;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const IconLabel({
    super.key,
    required this.label,
    this.textColor = Colors.black,
    this.fontSize = 6,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 4.0), // Padding wokół tekstu
        decoration: BoxDecoration(
          border:
              Border.all(color: Colors.black, width: 2), // Czarne obramowanie
          borderRadius: BorderRadius.circular(8), // Zaokrąglone rogi
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:
                200, // Maksymalna szerokość ramki (możesz dostosować do potrzeb)
          ),
          child: Text(
            label,
            textAlign:
                TextAlign.center, // Wyśrodkowanie tekstu w obrębie kontenera
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
