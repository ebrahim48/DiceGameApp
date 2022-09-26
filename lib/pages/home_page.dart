import 'dart:math';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final _diceList = <String>[
    "assets/image/d1.png",
    "assets/image/d2.png",
    "assets/image/d3.png",
    "assets/image/d4.png",
    "assets/image/d5.png",
    "assets/image/d6.png",
  ];

  int _dice1Image = 0, _dice2Image = 0, _diceSum = 0, _point = 0;
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  final _random = Random.secure();
  String _gameFinish = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: _hasGameStarted ? _gamePage() : _startPage(),
      ),
    );
  }

  Widget _gamePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/image/topimage.png", height: 150,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceList[_dice1Image],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 5,
            ),
            Image.asset(
              _diceList[_dice2Image],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
          ],
        ),
        Text(
          "Dice sum: $_diceSum",
          style: TextStyle(
              fontSize: 20, color: Colors.green, fontWeight: FontWeight.w500),
        ),
        if (_point > 0)
          Text(
            "Your point: $_point",
            style: TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        if (_point > 0 && !_isGameOver)
          Text("Keep rolling until you match your point",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w300)),
        if (_isGameOver)
          Text(
            _gameFinish,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20),
          ),
        _isGameOver
            ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            onPressed: _resetGame, child: Text("Play Again", style: TextStyle(fontSize: 18),))
            : ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            onPressed:_rollTheDice,
            child: Text("ROLL")),
      ],
    );
  }

  Widget _startPage() {
    return Column(
      children: [
        Text(
          "Game rules:",
          style: TextStyle(
              fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500,letterSpacing: 1, wordSpacing: 1),
        ),
        SizedBox(height: 20,),
        Text(
          "1. You win if you gate a 7 or 11 on the first throw.",
          style: TextStyle(
            fontSize: 18, color: Colors.green, ),
        ),
        Text(
          "2. You lose if you gate 2, 3 or 12 on the first throw.",
          style: TextStyle(
            fontSize: 18, color: Colors.green, ),
        ),
        Text(
          "3. If you gate 4 to 10 on the first throw you'll have to get the same point on second try. If you get a 7, you lose!",
          style: TextStyle(
            fontSize: 18, color: Colors.green, ),
        ),
        SizedBox(height: 200,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            onPressed: () {
              setState(() {
                _hasGameStarted = true;
              });
            },
            child: Text("Start Now >>")),
      ],
    );
  }

  void _rollTheDice() {
    setState(() {
      _dice1Image = _random.nextInt(6);
      _dice2Image = _random.nextInt(6);
      _diceSum = _dice1Image + _dice2Image + 2;

      if (_point > 0) {
        _checkSecondThrow();
      } else {
        _checkFirstThrow();
      }
    });
  }

  void _resetGame() {
    setState(() {
      _isGameOver = false;
      _dice1Image = 0;
      _dice2Image = 0;
      _diceSum = 0;
      _point = 0;
    });
  }

  void _checkFirstThrow() {
    switch (_diceSum) {
      case 7:
      case 11:
        _gameFinish = "Congratulation!! You win!";
        _isGameOver = true;
        break;
      case 2:
      case 3:
      case 12:
        _gameFinish = "Bad Luck! You lost!";
        _isGameOver = true;
        break;
      default:
        _point = _diceSum;
        break;
    }
  }

  void _checkSecondThrow() {
    if (_diceSum == _point) {
      _gameFinish = "Congratulation!! You win!";
      _isGameOver = true;
    } else if (_diceSum == 7) {
      _gameFinish = "Bad Luck! You lost!";
      _isGameOver = true;
    }
  }
}
