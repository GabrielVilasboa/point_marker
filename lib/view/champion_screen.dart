import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import 'package:point_marker/view/points_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class ChampionScreen extends StatefulWidget {
  final String name;

  const ChampionScreen({super.key, required this.name});

  @override
  _ChampionScreenState createState() => _ChampionScreenState();
}

class _ChampionScreenState extends State<ChampionScreen> {
  late ConfettiController _confettiController;
  late AudioPlayer _audioPlayer;


  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _audioPlayer = AudioPlayer();
    _playMusic();
    _confettiController.play(); // Start confetti animation on screen load
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.pause();
    super.dispose();
  }

  Future<void> _playMusic() async{
    await _audioPlayer.setSource(AssetSource('audio/celebration.mp3'));;
    await _audioPlayer.resume();
  }

  Path _drawStar(Size size) {
    double radius = size.width /2;
    double angle = (math.pi / 0.5) / 5;
    Path path = Path();
    for (int i = 0; i < 5; i++) {
      double x = radius * math.cos(angle * i);
      double y = radius * math.sin(angle * i);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
            constraints: const BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "O time Vencedor é:",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/rewards.png",
                      width: 200,
                    ),
                    Text(
                      "${widget.name}!",
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PointsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
                  child: const Text(
                    "Voltar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // Explode em todas as direções
            displayTarget: true,
            shouldLoop: true, // Loop de confete
            colors: const [
              Colors.black,
              Colors.red,
              Colors.green,
              Colors.yellow,
              Colors.orange,
              Colors.purple
            ], // Cores dos confetes
            createParticlePath: _drawStar, // Formato de estrela
          ),
        ],
      ),
    );
  }
}
