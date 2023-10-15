import 'package:flutter/material.dart';

class PiecesTaken extends StatelessWidget {
  final String imagePath;
  final bool isWhite;
  const PiecesTaken({super.key, required this.imagePath, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      color: isWhite ? Colors.grey[300] : Colors.grey[900],
    );
  }
}
