import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/services/select_images.dart';
import 'package:flutter_application_1/screens/home/services/upload_images.dart';
import '../../../common/theme_helper/theme_helper.dart';
import '../../widgets/HeaderWidget.dart';
import '../main_screen.dart';

class AgregarHabitacion extends StatefulWidget {
  final String urlImage;
  const AgregarHabitacion(this.urlImage, {super.key});

  @override
  State<AgregarHabitacion> createState() => _AgregarHabitacionState();
}

class _AgregarHabitacionState extends State<AgregarHabitacion> {
  final Key _formkey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  final db = FirebaseFirestore.instance;

  agregarHabitacionNow() async {
    try {
      print(widget.urlImage);

      if (widget.urlImage == "") {
        await db.collection('Habs').doc().set(
          {
            'title': firstName.text,
            'asigned_by': lastName.text,
            'image':
                "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/images%2Fno-disponible.png?alt=media&token=db473a25-e2db-4659-b20e-c29d9c214f49",
          },
        );
      } else {
        await db.collection('Habs').doc().set(
          {
            'title': firstName.text,
            'asigned_by': lastName.text,
            'image': widget.urlImage,
          },
        );
      }

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } catch (e) {
      print('error $e');
    }
  }

  anardirFoto(urlImage) {
    print("toco");
  }

  @override
  Widget build(BuildContext context) {
    String name = "user";
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 80),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            const Text(
              'Agregar habitación',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const SizedBox(
                height: 150,
                child: HeaderWidget(100, false, Icons.person),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return agregarImagen();
                                },
                              );
                            },
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Añadir imagen'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: firstName,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Nombre de la habitación',
                                  'Ingrese nombre de habitación'),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: lastName,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Creada por', 'ingrese su nombre'),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Añadir habitación".toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                agregarHabitacionNow();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class agregarImagen extends StatefulWidget {
  agregarImagen({
    super.key,
  });
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<agregarImagen> createState() => _ModalRenombrarCasaState();
}

class _ModalRenombrarCasaState extends State<agregarImagen> {
  File? imageGallery;
  String? urlImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 140,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final image = await selectImage();
                  setState(() {
                    imageGallery = File(image!.path);
                  });
                  if (imageGallery == null) {
                    return;
                  }
                  final url = await subirImagen(imageGallery!);
                  setState(() {
                    urlImage = url;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AgregarHabitacion(urlImage!)));
                },
                child: Text("Galería"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final image = await selectImageCamera();
                  setState(() {
                    imageGallery = File(image!.path);
                  });
                  if (imageGallery == null) {
                    return;
                  }
                  final url = await subirImagen(imageGallery!);
                  setState(() {
                    urlImage = url;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AgregarHabitacion(urlImage!)));
                },
                child: Text("Cámara"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return selectPredeterminada();
                    },
                  );
                },
                child: Text("Predeterminadas"),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}

class selectPredeterminada extends StatefulWidget {
  selectPredeterminada({
    super.key,
  });
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<selectPredeterminada> createState() => _ModalSelectPState();
}

class _ModalSelectPState extends State<selectPredeterminada> {
  File? imageGallery;
  String? urlImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 700,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        color: Colors.green,
      ),
      child: GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              const urlImage =
                  "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/comedor.jpg?alt=media&token=3a971ebb-1969-4652-b11d-0bc99c2fffd7";

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AgregarHabitacion(urlImage)));
            },
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/comedor.jpg?alt=media&token=3a971ebb-1969-4652-b11d-0bc99c2fffd7"),
          ),
          GestureDetector(
            onTap: () {
              const urlImage =
                  "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/habitacion.jpg?alt=media&token=ed755baa-3624-4097-ab60-f7bdbf8b9210";

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AgregarHabitacion(urlImage)));
            },
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/habitacion.jpg?alt=media&token=ed755baa-3624-4097-ab60-f7bdbf8b9210",
                height: 500),
          ),
          GestureDetector(
            onTap: () {
              const urlImage =
                  "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/bano-estrecho-12m-m.jpg?alt=media&token=da902c1c-c19f-486b-80ed-c7863c7647bc";

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AgregarHabitacion(urlImage)));
            },
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/bano-estrecho-12m-m.jpg?alt=media&token=da902c1c-c19f-486b-80ed-c7863c7647bc",
              height: 500,
            ),
          ),
          GestureDetector(
            onTap: () {
              const urlImage =
                  "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/cocina-moderna-7m-m.jpg?alt=media&token=8d1b5836-dcac-457d-b941-6c6e371a7017";

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AgregarHabitacion(urlImage)));
            },
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/dohm-baa5d.appspot.com/o/cocina-moderna-7m-m.jpg?alt=media&token=8d1b5836-dcac-457d-b941-6c6e371a7017",
              height: 500,
            ),
          ),
        ],
      ),
    );
  }
}
