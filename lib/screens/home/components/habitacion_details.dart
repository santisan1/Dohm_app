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
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habitación 1"),
      ),
      body: Center(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text("Estado luz"),
              secondary: const Icon(Icons.light_mode),
              value: _isactivated,
              activeColor: Colors.blue,
              onChanged: (newBool) {
                setState(
                  () {
                    _isactivated = newBool;
                    if (_isactivated == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                          content: Text("Luz prendida"),
                        ),
                      );
                    }
                    if (_isactivated == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                          content: Text("Luz apagada"),
                        ),
                      );
                    }
                  },
                );
                saveNombreHogar(_isactivated, _currentSliderValue);

                print(_isactivated);
              },
            ),
            Slider(
              inactiveColor: Colors.grey,
              value: _currentSliderValue,
              max: 100,
              divisions: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(
                  () {
                    _currentSliderValue = value;
                    saveNombreHogar(_isactivated, _currentSliderValue);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
