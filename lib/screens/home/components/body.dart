import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          HeaderHomeWidget(size: size, currentName: currentName),
          Container(
              height: 24,
              child: Stack(
                children: [Text('Recomended')],
              )),
        ],
      ),
    );
  }
}
