import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -10),
                blurRadius: 35,
                color: Theme.of(context).primaryColor.withOpacity(0.4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 30,
              )),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
