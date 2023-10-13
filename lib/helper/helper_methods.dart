bool isWhite( int index ) {
  int x = index ~/8; //gives the integer division (row)
  int y = index %8; //gives the reminder (column)

  //alternates the colors for every square
  bool isWhite = (x + y) %2 == 0;

  return isWhite;
}

bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}