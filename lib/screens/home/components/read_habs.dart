import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  final _uberStream = FirebaseFirestore.instance.collection("Habs").snapshots();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        return GridView.builder(
          itemCount: docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
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
                                    text: docs[index]['title'].toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text: "\nCreado por: ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
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
        );
      },
    );
  }
}

// ListTile(
//                 leading: Image.network(docs[index]["image"]),
//                 title: Text(docs[index]['title']),
//                 subtitle: Text(docs[index]["asigned_by"]),
//               );