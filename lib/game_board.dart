import 'package:flutter/material.dart';
import 'package:flutter_chess_game/components/chesspiece.dart';
import 'package:flutter_chess_game/components/square.dart';
import 'package:flutter_chess_game/helper/helper_methods.dart';
import 'package:flutter_chess_game/values/colors.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //A 2 dimensional list representing the chessboard
  late List<List<ChessPiece?>> board;

  //the current piece selected on the chess board
  ChessPiece? selectedPiece;

  //the row index of the piece selected
  int selectedRow = -1;

  //the col index of the piece selected
  int selectedCol = -1;

  //a list of valid moves for the selected piece
  //where every move is represented as a list with 2 elements (row and col)
  List<List<int>> validMoves = [];

  @override
  void initState() {
    _initializeBoard();
    super.initState();
  }

  //board initialization
  void _initializeBoard() {
    //initialize the board with nulls, meaning no pieces in these positions
    List<List<ChessPiece?>> newboard =
    List.generate(8 , (index) => List.generate(8, (index) => null));

    //place rando, in the middle
    newboard[3][3] = ChessPiece(type: ChessPieceType.queen, isWhite: false, imagePath: 'images/queen.png');
    //we place the pawns
    for (int i = 0; i < 8; i++) {
      newboard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'images/pawn.png',
      );
      newboard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'images/pawn.png',
      );
    }

    //we place the rooks
    newboard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'images/rook.png',
    );
    newboard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'images/rook.png',
    );
    newboard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'images/rook.png',
    );
    newboard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'images/rook.png',
    );

    //we place the knights
    newboard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'images/knight.png',
    );
    newboard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'images/knight.png',
    );
    newboard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'images/knight.png',
    );
    newboard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'images/knight.png',
    );

    //we place the bishops
    newboard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'images/bishop.png',
    );
    newboard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'images/bishop.png',
    );
    newboard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'images/bishop.png',
    );
    newboard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'images/bishop.png',
    );

    //we place the queens
    newboard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: 'images/queen.png',
    );
    newboard[7][4] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: 'images/queen.png',
    );
    //we place the kings
    newboard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: 'images/king.png',
    );
    newboard[7][3] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: 'images/king.png',
    );

    board = newboard;

  }
  //piece selected by the user
  void pieceSelected(int row, int col) {
    setState(() {
      //selected a piece if there is on that position
      if (board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      //after selection define the valid moves
      validMoves = calculateRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  //Calculate the raw valid moves
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves =  [];

    //different direction according to color
    int direction = piece!.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        //pawn can move forward if the is square is not occupied
      if (isInBoard(row + direction, col) &&
          board[row + direction][col] == null) {
        candidateMoves.add([row + direction, col]);
      }
        //pawn can move 2 squares forward from its initial position
      if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
        if (isInBoard(row + 2 * direction, col) &&
            board[row + 2 * direction][col] == null &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + 2 * direction, col]);
        }
      }
        //pawn can capture diagonally
      if (isInBoard(row + direction, col - 1) &&
          board[row + direction][col - 1] != null &&
          board[row + direction][col - 1] !.isWhite) {
        candidateMoves.add([row + direction, col - 1]);
      }
      if (isInBoard(row + direction, col + 1) &&
          board[row + direction][col + 1] != null &&
          board[row + direction][col + 1] !.isWhite) {
        candidateMoves.add([row + direction, col + 1]);
      }

        break;
      case ChessPieceType.rook:
        //horizontal and vertical directions
      var directions = [
        [-1,0], //up
        [1,0], //down
        [0,-1], //left
        [0,1], //right
      ];

      for (var direction in directions) {
        var i = 0;
        var newRow = row + i * direction[0];
        var newCol = col + i * direction[1];
        if (!isInBoard(newRow, newCol)) {
          break;
        }
        if (board[newRow][newCol] != null) {
          if (board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]);//capture
          }
          break;//blocked
        }
        candidateMoves.add([newRow, newCol]);
        i++;
      }
        break;
      case ChessPieceType.knight:
         //all eight possible L moves
      var knightMoves = [
        [-2, -1], // 2 up 1 left
        [-2, 1], // 2 up 1 right
        [-1, -2], // 1 up right 2
        [-1, 2], // 1 up 2 right
        [1, -2], // 1 down 2 left
        [1, 2], //1 down 2 right
        [2, -1], // 2 down 1 left
        [2, 1], // 2 down 1 right
      ];

      for (var move in knightMoves) {
        var newRow = row + move[0];
        var newCol = col + move[1];
        if (!isInBoard(newRow, newCol)) {
          continue;
        }
        if (board[newRow][newCol] != null) {
          if (board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]); //capture
          }
          continue;
        }
        candidateMoves.add([newRow, newCol]);
      }
        break;

      case ChessPieceType.bishop:
        //diagonal directions
        var directions = [
          [-1,-1], //up left
          [-1,1], //up right
          [1,-1], //down left
          [1,1], //down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); //capture
              }
              break; //block
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;

      case ChessPieceType.queen:
        //all eight directions: up, down , left, right, and 4 diagonals
      var directions = [
        [-1,0],//up
        [1,0],//down
        [0,-1],//left
        [0,1],//right
        [-1,-1],//up left
        [-1,1],//up right
        [1,-1],//down left
        [1,1],//down right
      ];

      for (var direction in directions) {
        var i = 1;
        while (true) {
          var newRow = row + i * direction[0];
          var newCol = col + i * direction[1];
          if (!isInBoard(newRow, newCol)) {
            break;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]);
            }
            break; //block
          }
          candidateMoves.add([newRow, newCol]);
          i++;
        }
      }
        break;
      case ChessPieceType.king:
        //all eight directions
        var directions = [
          [-1,0],//up
          [1,0],//down
          [0,-1],//left
          [0,1],//right
          [-1,-1],//up left
          [-1,1],//up right
          [1,-1],//down left
          [1,1],//down right
        ];
        for (var direction in directions) {
          while (true) {
            var newRow = row + direction[0];
            var newCol = col + direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break; //block
            }
            candidateMoves.add([newRow, newCol]);
          }
        }
        break;
      default:
    }

    return candidateMoves;
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: 8 * 8,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),

        itemBuilder: (context, index) {
          //let us put the correct positions
          int row = index ~/ 8;
          int col = index % 8;

          //check if selected
          bool isSelected = selectedRow == row && selectedCol == col;

          //check if the square is a valid move
          bool isValidMove = false;
          for (var position in validMoves) {
            if (position[0] == row && position[1] == col) {
              isValidMove = true;
            }
          }
          return Square(
            isWhite: isWhite(index),
            piece: board[row][col],
            isSelected: isSelected,
            isValidMove: isValidMove,
            onTap: () => pieceSelected(row, col),
          );
        }
      ),
    );
  }
}
