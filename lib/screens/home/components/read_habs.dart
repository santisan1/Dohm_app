import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/habs_model.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    ReadDataFunc();
  }

  Future<void> ReadDataFunc() async {
    await FirebaseFirestore.instance
        .collection('Habs')
        .orderBy('title')
        .snapshots()
        .listen(
      (event) {
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          HabsModel model = HabsModel.fromMap(map);
          print(model.title);
          for (var i in event.docs) {
            widgets.add(CreateWidget(model));
          }
        }
      },
    );
  }

  Widget CreateWidget(HabsModel model) => Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                print('toco');
              },
              child: Image.network(
                model.image,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: Theme.of(context).primaryColor.withOpacity(0.23))
                ]),
                child: Row(children: [
                  Text(
                    model.title.toUpperCase(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A'),
      ),
      body: widgets.isEmpty
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
              ),
              itemCount: widgets.length,
              itemBuilder: (_, index) {
                return GridView.extent(
                    maxCrossAxisExtent: 400, children: widgets);
              }),
    );
  }
}
