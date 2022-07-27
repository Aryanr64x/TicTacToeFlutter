import 'package:flutter/material.dart';
import 'package:tictactoe/move.dart';
import 'package:tictactoe/move_tracker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Move> moves = [];
  MoveTracker moveTracker = MoveTracker();

  Widget _displayMoveAsPerIndex(int index) {
    if (moveTracker.getMoveType(index) == "user") {
      return const Image(
        image: AssetImage("images/cross.png"),
        height: 30,
        width: 30,
      );
    } else {
      return const Image(
        image: AssetImage("images/circle.png"),
        height: 30,
        width: 35,
      );
    }
  }

  List<Widget> displayChildren() {
    List<Widget> children = [];
    for (int i = 0; i < 9; i++) {
      children.add(
        GestureDetector(
            child: Container(
              height: 30,
              color: Colors.red,
              child: moveTracker.checkMoveExists(i)
                  ? (_displayMoveAsPerIndex(i))
                  : null,
            ),
            onTap: () {
              onTap(i);
            }),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "TIC TAC TOE",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: displayChildren()),
      ),
    );
  }

  void onTap(int i) async {
    moveTracker.addUserMove("user", i);
    if (moveTracker.ifUserWon()) {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: const Text("CONGRATS ! You have won"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      moveTracker.deleteAllMoves();

                      setState(() {});
                    },
                    child: const Text("Replay"))
              ],
            );
          }));
    } else {
      await moveTracker.addComputerMove();
      if (moveTracker.ifComputerWon()) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("OH NO ! The computer has won "),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        moveTracker.deleteAllMoves();

                        setState(() {});
                      },
                      child: const Text("Replay"))
                ],
              );
            });
      }
    }

    setState(() {});
  }
}
