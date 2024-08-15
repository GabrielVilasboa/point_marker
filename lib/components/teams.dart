import 'package:flutter/material.dart';
import 'package:point_marker/view/champion_screen.dart';
import '../data/data.dart';

class Team extends StatefulWidget {
  final int value;
  final String name;
  final bool isPlayerOne;
  final VoidCallback resetValues;

  const Team(
      {super.key,
      required this.value,
      required this.name,
      required this.isPlayerOne,
      required this.resetValues});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 0;
  String image = "assets/images/clubs_white.png";

  void _incrementCounter() {
    setState(() {
      _counter += widget.value;
      if (_counter >= 12) {
        _counter = 0;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChampionScreen(name: widget.name)));
      }
      widget.resetValues();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.name;
    if (widget.isPlayerOne) {
      image = "assets/images/espadas_white.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Player Name
        SizedBox(
          width: 100,
          child: TextField(
            maxLength: 9,
            controller: _controller,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: InputBorder.none, counterText: ''),
            onChanged: (text) {
              if (widget.isPlayerOne) {
                Data.nameTeamOne = text;
              } else {
                Data.nameTeamTwo = text;
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 60),
          child: SizedBox(
              width: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    image,
                    width: 130,
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _decrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  fixedSize: const Size(18, 18),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  alignment: Alignment.center,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                child: const Text(
                  "-",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
                child: Text(
                  "+ ${widget.value}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
