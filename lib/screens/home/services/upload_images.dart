import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

Future<String> subirImagen(File image) async {
  print(image.path);
  final String nameFile = image.path.split("/").last;
  final Reference ref = storage.ref().child("images").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  print(uploadTask);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  return url;
}

Future<String> subirPredeterminadas(int control) async {
  String url = "";
  if (control == 1) {
    print("Selecciono Comedor");
    url =
        "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/comedor.jpg?alt=media&token=3a971ebb-1969-4652-b11d-0bc99c2fffd7";
  }
  if (control == 2) {
    print("Selecciono dormitorio");
    url =
        "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/habitacion.jpg?alt=media&token=ed755baa-3624-4097-ab60-f7bdbf8b9210";
  }
  if (control == 3) {
    print("Selecciono baño");
    url =
        "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/bano-estrecho-12m-m.jpg?alt=media&token=da902c1c-c19f-486b-80ed-c7863c7647bc";
  }
  if (control == 4) {
    print("Selecciono cocina");
    url =
        "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/cocina-moderna-7m-m.jpg?alt=media&token=8d1b5836-dcac-457d-b941-6c6e371a7017";
  }
  print(url);
  return url;
}
