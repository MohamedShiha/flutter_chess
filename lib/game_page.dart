import 'package:flutter/material.dart';
import 'package:flutter_chess/model/board.dart';
import 'package:flutter_chess/model/game.dart';
import 'package:flutter_chess/model/piece.dart';

import 'model/pawn.dart';

final moveColors = {
  MoveType.ilVaticano: Colors.purple.withOpacity(0.7),
  MoveType.castle: Colors.yellow.withOpacity(0.7),
  MoveType.enPassant: Colors.red[800]!.withOpacity(0.7),
};

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  ChessGame game = ChessGame();

  List<Move> availableMoves = [];

  Move? selectedPiece;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turn ${game.turn.name}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int y = 0; y < 8; y++)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int x = 0; x < 8; x++)
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Builder(builder: (_) {
                        Move pos = Move(x, y);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              availableMoves = [];
                              selectedPiece = null;

                              var moves = game.select(pos).toList();
                              if (moves.isEmpty) return;

                              availableMoves = moves.toList();
                              selectedPiece = pos;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                  color: (x + y) % 2 == 0
                                      ? Colors.grey
                                      : Colors.grey[300],
                                  child: game.board[pos] == null
                                      ? const SizedBox.expand()
                                      : Image.asset(game.board[pos]!.image)),
                              if (selectedPiece == pos)
                                Container(
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                              if (availableMoves
                                  .any((move) => move == Move(x, y)))
                                GestureDetector(
                                  onTap: () async {
                                    var selectedMove =
                                        availableMoves.firstWhere(
                                            (move) => move == Move(x, y));
                                    setState(() {
                                      game.play(selectedPiece!, selectedMove);

                                      availableMoves = [];
                                      selectedPiece = null;
                                    });

                                    if (selectedMove.type != MoveType.normal) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(selectedMove.type.name),
                                        backgroundColor:
                                            moveColors[selectedMove.type],
                                      ));
                                    }

                                    // promote pawn
                                    if (game.board[pos]!.mobility is Pawn &&
                                        (y == 0 || y == 7)) {
                                      var team = game.turn;
                                      game.board[pos] = await showDialog<Piece>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                          "Pawn Promotion!"),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: (team ==
                                                                    Team.black
                                                                ? [
                                                                    wQueen,
                                                                    wBishop,
                                                                    wKnight,
                                                                    wRook,
                                                                  ]
                                                                : [
                                                                    bQueen,
                                                                    bBishop,
                                                                    bKnight,
                                                                    bRook,
                                                                  ])
                                                            .map(
                                                              (piece) =>
                                                                  Expanded(
                                                                child: InkWell(
                                                                  child: Image
                                                                      .asset(
                                                                    piece.image,
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        piece);
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ]),
                                              ));

                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                      color: moveColors[availableMoves
                                              .firstWhere((move) => move == pos)
                                              .type] ??
                                          (game.board.isEmpty(pos)
                                              ? Colors.green.withOpacity(0.5)
                                              : Colors.red.withOpacity(0.7))),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
              ],
            ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: const Text("Reset"),
                onPressed: () {
                  setState(() {
                    game = ChessGame();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
