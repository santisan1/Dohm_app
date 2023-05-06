import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/header_filter.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';

import 'header_home_page.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});
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
        child: Column(children: [
      HeaderHomeWidget(
        size: size,
        currentName: currentName,
        pressProfile: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      TittleHeaderWithFilter(tittle: "Habitaciones", press: () {}),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            NewHabitacionCard(
              image: 'title',
              tittle: 'Cuarto 1',
              press: () {
                print('toco');
              },
            ),
            NewHabitacionCard(
              image: 'assets/cocina.jpg',
              tittle: 'Cocina',
              press: () {
                print('toco');
              },
            ),
            NewHabitacionCard(
              image: 'assets/comedor.jpg',
              tittle: 'Comedor',
              press: () {
                print('toco');
              },
            ),
          ],
        ),
      )
    ]));
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
      margin: EdgeInsets.only(left: 20, top: 10, bottom: 20 * 2.5),
      height: size.width * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: press,
            child: Image.asset(
              image,
              width: 170,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.23))
              ]),
              child: Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '$tittle'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.9)))
                  ]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
