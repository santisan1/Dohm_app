import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/header_filter.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';

import 'habitacion_details.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderHomeWidget(
            size: size,
            currentName: currentName,
            valueCasa: "",
            pressProfile: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          TittleHeaderWithFilter(tittle: "Habitaciones", press: () {}),
          Container(
            height: 300,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
              ),
              children: <Widget>[
                NewHabitacionCard(
                    image: 'assets/habitacion.jpg',
                    tittle: "tittle",
                    press: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return new HabitacionDetails();
                        },
                      ));
                    }),
                NewHabitacionCard(
                    image: 'assets/habitacion.jpg',
                    tittle: "tittle",
                    press: () {}),
                NewHabitacionCard(
                    image: 'assets/habitacion.jpg',
                    tittle: "tittle",
                    press: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewHabitacionCard extends StatelessWidget {
  const NewHabitacionCard({
    super.key,
    required this.image,
    required this.tittle,
    required this.press,
  });

  final String image, tittle;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      height: size.width * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: press,
            child: Image.asset(
              image,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.23))
              ]),
              child: Row(children: [
                Text(
                  tittle.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
