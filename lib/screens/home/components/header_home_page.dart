import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/user_services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHomeWidget extends StatefulWidget {
  const HeaderHomeWidget({
    super.key,
    required this.size,
    required this.currentName,
    required this.pressProfile,
  });

  final Size size;
  final String currentName;

  final void Function() pressProfile;

  @override
  State<HeaderHomeWidget> createState() => _HeaderHomeWidgetState();
}

class _HeaderHomeWidgetState extends State<HeaderHomeWidget> {
  final casa = "Casa 1";
  String? valueCasa;
  @override
  void initState() {
    super.initState();
    cargarpreferencias();
  }

  cargarpreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        valueCasa = prefs.getString("NombreCasa") ?? "Casa 1";
        print("casa: $valueCasa");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10 * 2.5),
      height: widget.size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            height: widget.size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Hi ${widget.currentName}!",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: widget.pressProfile,
                    child: Icon(Icons.person_2_outlined,
                        color: Colors.grey.shade300, size: 45.0),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.40),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$valueCasa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalRenombrarCasa();
                          });
                    },
                    icon: SvgPicture.asset('assets/Icons/rename.svg'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModalRenombrarCasa extends StatefulWidget {
  ModalRenombrarCasa({super.key});

  @override
  State<ModalRenombrarCasa> createState() => _ModalRenombrarCasaState();
}

class _ModalRenombrarCasaState extends State<ModalRenombrarCasa> {
  final TextEditingController _nombreCasa = TextEditingController();
  final GlobalKey<FormState> _formularioKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String? valueCasa;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 170,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        color: Colors.white,
      ),
      child: Form(
        key: _formularioKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nombreCasa,
              validator: (String? dato) {
                if (dato!.isEmpty) {
                  return "este campo es requerido";
                }
                return null;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Renombrar casa"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      valueCasa = _nombreCasa.text;
                    });

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      prefs.setString("NombreCasa", _nombreCasa.text);
                    });
                    if (_formularioKey.currentState!.validate()) {
                      bool respuesta = await UserServices().saveNombreHogar(
                        _nombreCasa.text,
                      );
                      if (respuesta == true) {
                        print("todo ok");
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Renombrada con éxito"),
                          ),
                        );
                      } else {
                        print("todo mal");
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Algo salió mal"),
                        );
                      }
                    }
                  },
                  child: Text("Aceptar"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreCasa.dispose();
    super.dispose();
  }
}
