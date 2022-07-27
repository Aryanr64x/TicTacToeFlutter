import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/move.dart';

class MoveTracker {
  List<Move> _moves = [];

  void addUserMove(String type, int index) {
    _moves.add(Move(type: type, index: index));
  }

  void deleteAllMoves() {
    _moves = [];
  }

  Future<void> addComputerMove() async {
    List<int> filledIndicies = [];
    for (Move move in _moves) {
      filledIndicies.add(move.index);
    }
    Random random = Random();
    int newIndex = await getNewIndex(random, filledIndicies);
    _moves.add(Move(type: "computer", index: newIndex));
  }

  // Recursion in use !!
  Future<int> getNewIndex(Random random, List<int> filledIndicies) async {
    int number = random.nextInt(8);
    if (filledIndicies.contains(number)) {
      return await getNewIndex(random, filledIndicies);
    } else {
      return number;
    }
  }

  bool ifUserWon() {
    List<int> userFilledIndicies = [];
    for (Move move in _moves) {
      if (move.type == "user") {
        userFilledIndicies.add(move.index);
      }
    }

    if (userFilledIndicies.contains(0) &&
        userFilledIndicies.contains(1) &&
        userFilledIndicies.contains(2)) {
      return true;
    } else if (userFilledIndicies.contains(0) &&
        userFilledIndicies.contains(3) &&
        userFilledIndicies.contains(6)) {
      return true;
    } else if (userFilledIndicies.contains(0) &&
        userFilledIndicies.contains(4) &&
        userFilledIndicies.contains(7)) {
      return true;
    } else if (userFilledIndicies.contains(1) &&
        userFilledIndicies.contains(4) &&
        userFilledIndicies.contains(7)) {
      return true;
    } else if (userFilledIndicies.contains(2) &&
        userFilledIndicies.contains(5) &&
        userFilledIndicies.contains(8)) {
      return true;
    } else if (userFilledIndicies.contains(2) &&
        userFilledIndicies.contains(4) &&
        userFilledIndicies.contains(6)) {
      return true;
    } else if (userFilledIndicies.contains(3) &&
        userFilledIndicies.contains(4) &&
        userFilledIndicies.contains(5)) {
      return true;
    } else if (userFilledIndicies.contains(6) &&
        userFilledIndicies.contains(7) &&
        userFilledIndicies.contains(8)) {
      return true;
    } else {
      return false;
    }
  }

  bool ifComputerWon() {
    List<int> computerFilledIndicies = [];
    for (Move move in _moves) {
      if (move.type == "computer") {
        computerFilledIndicies.add(move.index);
      }
    }

    if (computerFilledIndicies.contains(0) &&
        computerFilledIndicies.contains(1) &&
        computerFilledIndicies.contains(2)) {
      return true;
    } else if (computerFilledIndicies.contains(0) &&
        computerFilledIndicies.contains(3) &&
        computerFilledIndicies.contains(6)) {
      return true;
    } else if (computerFilledIndicies.contains(0) &&
        computerFilledIndicies.contains(4) &&
        computerFilledIndicies.contains(7)) {
      return true;
    } else if (computerFilledIndicies.contains(1) &&
        computerFilledIndicies.contains(4) &&
        computerFilledIndicies.contains(7)) {
      return true;
    } else if (computerFilledIndicies.contains(2) &&
        computerFilledIndicies.contains(5) &&
        computerFilledIndicies.contains(8)) {
      return true;
    } else if (computerFilledIndicies.contains(2) &&
        computerFilledIndicies.contains(4) &&
        computerFilledIndicies.contains(6)) {
      return true;
    } else if (computerFilledIndicies.contains(3) &&
        computerFilledIndicies.contains(4) &&
        computerFilledIndicies.contains(5)) {
      return true;
    } else if (computerFilledIndicies.contains(6) &&
        computerFilledIndicies.contains(7) &&
        computerFilledIndicies.contains(8)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkMoveExists(int index) {
    bool exists = false;

    for (Move move in _moves) {
      if (move.index == index) {
        exists = true;
      }
    }

    return exists;
  }

  String? getMoveType(int index) {
    for (Move move in _moves) {
      if (move.index == index) {
        return move.type;
      }
    }
  }
}
