import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HabitacionDetails extends StatefulWidget {
  const HabitacionDetails({super.key});

  @override
  State<HabitacionDetails> createState() => _HabitacionDetailsState();
}

class _HabitacionDetailsState extends State<HabitacionDetails> {
  bool? _isactivated = false;
  double _currentSliderValue = 20;
  saveNombreHogar(isactivated, currenintensity) async {
    try {
      if (isactivated == false) {
        await FirebaseDatabase.instance.ref("DataLuces").set({
          'led': 0,
          "intensidad": 0,
        });
      }
      if (isactivated == true) {
        await FirebaseDatabase.instance.ref("DataLuces").set({
          'led': 1,
          "intensidad": currenintensity,
        });
      }

      print("Listop");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("a"),
      ),
      body: Center(
        child: Column(
          children: [
            Checkbox(
              value: _isactivated,
              activeColor: Colors.blue,
              onChanged: (NewBool) {
                setState(() {
                  _isactivated = NewBool;
                });
                saveNombreHogar(_isactivated, _currentSliderValue);

                print(_isactivated);
              },
            ),
            Slider(
                value: _currentSliderValue,
                max: 100,
                divisions: 100,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    saveNombreHogar(_isactivated, _currentSliderValue);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
