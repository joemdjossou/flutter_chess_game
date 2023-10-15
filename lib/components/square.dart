import 'package:flutter/material.dart';
import 'package:flutter_chess_game/components/chesspiece.dart';
import 'package:flutter_chess_game/values/colors.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final void Function()? onTap;


  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.isValidMove
  });

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    //if selected green if not white or black

    if (isSelected) {
      squareColor = Colors.orange;
  } else if(isValidMove) {
      squareColor = Colors.orange[200];
    }else {
      squareColor = isWhite ? foregroundColor : backgroundColor;
  }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        margin: EdgeInsets.all(isValidMove ? 5 : 0),
        child: piece != null
            ? Image.asset(
            piece!.imagePath,
            color: piece!.isWhite
                ? Colors.white :
            Colors.black,
        )
            : null,
      ),
    );
  }
}
