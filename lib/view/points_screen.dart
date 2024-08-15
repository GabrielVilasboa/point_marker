import 'package:flutter/material.dart';
import 'package:point_marker/data/data.dart';
import '../components/teams.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({
    super.key,
  });

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  int _value = 1;
  String _trucoButton = "Truco";

  void _resetValues(){
    setState(() {
      _value = 1;
      _trucoButton = "Truco";
    });
  }

  void _incrementValue() {
    List<dynamic> valueChange = [_value, _trucoButton];
    switch (_value) {
      case 1:
        valueChange = [3, "Seis"];
        break;
      case 3:
        valueChange = [6, "Nove"];
        break;
      case 6:
        valueChange = [9, "Doze"];
        break;
      case 9:
        valueChange = [12, "Voltar"];
        break;
      default:
        valueChange = [1, "Truco"];
    }
    setState(() {
      _value = valueChange[0];
      _trucoButton = valueChange[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "Marcador de Pontos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Team(
                  value: _value,
                  name: Data.nameTeamOne,
                  isPlayerOne: true,
                  resetValues: _resetValues,

                ),
                Team(
                  value: _value,
                  name: Data.nameTeamTwo,
                  isPlayerOne: false,
                  resetValues: _resetValues,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _incrementValue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900]
              ),
              child: Text(_trucoButton, style: const TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
