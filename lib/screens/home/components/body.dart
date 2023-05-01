import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Theme.of(context).primaryColor.withOpacity(0.40))
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                            controller: _valueCasa,
                            onChanged: (casa) {
                              print("object $casa");
                            },
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.7),
                              hintText: casa,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7)),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            )),
                      )),
                    ),
                    IconButton(
                        onPressed: () => _printLatestValue(),
                        icon: SvgPicture.asset('assets/Icons/rename.svg'))
                  ],
                )),
          ),
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
