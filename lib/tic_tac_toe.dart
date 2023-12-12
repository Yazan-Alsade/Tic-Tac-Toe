import 'dart:io';

// Define a class for the Tic-Tac-Toe game
class TicTacToe {
  // Instance variables
  List<String> board; // Represents the Tic-Tac-Toe board
  String currentPlayer; // Represents the current player ('X' or 'O')

  // Constructor to initialize the board and current player
  TicTacToe()
      : board = List.generate(9, (index) => (index + 1).toString()),
        currentPlayer = 'X';

  // Method to print the current state of the board
  void printBoard() {
    for (var i = 0; i < 3; i++) {
      print('| ${board[i * 3]} | ${board[i * 3 + 1]} | ${board[i * 3 + 2]} |');
    }
    print('-------------');
  }

  // Method to check if a specific cell on the board is empty
  bool isCellEmpty(int position) {
    return board[position - 1] == position.toString();
  }

  // Method to switch the current player between 'X' and 'O'
  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  // Method to check for winning conditions on the board
  bool checkWin() {
    // Check rows, columns, and diagonals for a win
    for (var i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] && board[i * 3 + 1] == board[i * 3 + 2]) {
        return true;
      }
      if (board[i] == board[i + 3] && board[i + 3] == board[i + 6]) {
        return true;
      }
    }

    if (board[0] == board[4] && board[4] == board[8]) {
      return true;
    }
    if (board[2] == board[4] && board[4] == board[6]) {
      return true;
    }

    return false;
  }

  // Method to check if the board is full
  bool isBoardFull() {
    return board.every((cell) => cell == 'X' || cell == 'O');
  }

  // Method to handle the main game loop
  void play() {
    int move;
    bool validMove;

    do {
      printBoard();
      validMove = false;

      do {
        // Prompt the current player to enter their move
        stdout.write('Player $currentPlayer, enter your move (1-9): ');

        try {
          move = int.parse(stdin.readLineSync()!);
        } catch (e) {
          move = -1; // Invalid input, set move to -1
        }

        // Validate the entered move
        if (move >= 1 && move <= 9 && isCellEmpty(move)) {
          validMove = true;
        } else {
          print('Invalid move. Please try again.');
        }
      } while (!validMove);

      // Update the board with the current player's move
      board[move - 1] = currentPlayer;

      // Check for a win or a draw
      if (checkWin()) {
        printBoard();
        print('Player $currentPlayer wins!');
        return;
      } else if (isBoardFull()) {
        printBoard();
        print('It\'s a draw!');
        return;
      }

      // Switch to the next player for the next turn
      switchPlayer();
    } while (true);
  }
}

// Main function to initiate the game
void main() {
  print('Welcome to Tic-Tac-Toe!');

  while (true) {
    // Create an instance of the TicTacToe class and start the game
    TicTacToe game = TicTacToe();
    game.play();

    // Ask the user if they want to play again
    stdout.write('Do you want to play again? (yes/no): ');
    String playAgain = stdin.readLineSync()!.toLowerCase();

    // If the user does not want to play again, exit the game
    if (playAgain != 'yes') {
      print('Thanks for playing. Goodbye!');
      break;
    }
  }
}
