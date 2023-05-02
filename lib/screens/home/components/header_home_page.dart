import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderHomeWidget extends StatelessWidget {
  HeaderHomeWidget({
    super.key,
    required this.size,
    required this.currentName,
    required this.pressProfile,
  });

  final Size size;
  final String currentName;
  final _valueCasa = TextEditingController();
  final casa = "Casa 1";
  final void Function() pressProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10 * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "Hi $currentName!",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: pressProfile,
                      child: Icon(Icons.person_2_outlined,
                          color: Colors.grey.shade300, size: 45.0),
                    ))
              ],
            ),
          ),
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
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/Icons/rename.svg'))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
