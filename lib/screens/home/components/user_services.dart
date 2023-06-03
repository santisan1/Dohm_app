import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class UserServices {
  Future<bool> saveNombreHogar(String nombreCasa) async {
    try {
      await FirebaseDatabase.instance.ref().child("ultimo").set({
        'nombre_casa': nombreCasa,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Widget listItem({Map? nombreCasa}) {
    print(nombreCasa?["nombre_casa"]);
    return Container(
      child: Text(nombreCasa?["nombre_casa"] ?? Text("a").toString()),
    );
  }

  getName() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('ultimo').get();

      print(snapshot.value);
      Map nombreCasa = snapshot.value as Map;
      nombreCasa['key'] = snapshot.key;
      print(nombreCasa["nombre_casa"]);
      return listItem(nombreCasa: nombreCasa);
    } catch (e) {
      print(e);
    }
  }
}
