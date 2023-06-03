import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/header_filter.dart';
import 'package:flutter_application_1/screens/home/services/crear_habitacion.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'header_home_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  var currentName = "User";
  final _valueCasa = TextEditingController();
  final casa = "Casa 1";
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _valueCasa.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _valueCasa.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${_valueCasa.text}');
  }

  final _uberStream = FirebaseFirestore.instance.collection("Habs").snapshots();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: _uberStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Cargando");
        }
        var docs = snapshot.data!.docs;
        return SingleChildScrollView(
          child: Column(
            children: [
              HeaderHomeWidget(
                size: size,
                currentName: currentName,
                pressProfile: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              TittleHeaderWithFilter(tittle: "Habitaciones", press: () {}),
              GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: size.width * 0.4,
                    margin: const EdgeInsets.only(
                      bottom: 25,
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.network(
                              docs[index]["image"],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 50,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.43),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: docs[index]['title']
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: "\nCreado por: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: docs[index]['asigned_by'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AgregarHabitacion("")));
                },
                icon: const Icon(Icons.add),
                iconSize: 39,
              )
            ],
          ),
        );
      },
    );
  }
}
