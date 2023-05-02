import 'package:flutter/material.dart';

class TittleHeaderWithFilter extends StatelessWidget {
  const TittleHeaderWithFilter({
    super.key,
    required this.tittle,
    required this.press,
  });
  final String tittle;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          HeaderTittle(
            text: tittle,
          ),
          TextButton(
            onPressed: press,
            child: const Text('Filtrar'),
          ),
        ],
      ),
    );
  }
}

class HeaderTittle extends StatelessWidget {
  const HeaderTittle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 24,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20 / 4),
              child: Text(
                text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20 / 4),
                height: 7,
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            )
          ],
        ));
  }
}
