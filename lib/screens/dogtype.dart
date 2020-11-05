import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dogtype extends StatefulWidget {
  @override
  _DogtypeState createState() => _DogtypeState();
}

class _DogtypeState extends State<Dogtype> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Card(
        //   child: TextField(
        //     decoration: InputDecoration(
        //         prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        //     onChanged: (val) {
        //       setState(() {
        //         name = val;
        //       });
        //     },
        //   ),
        // ),
      ),
      body: realto(),
    );
  }

  realto() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("words")
          .where('type', isEqualTo: 'DOG')
          .snapshots(),
      builder: (context, snapshots) {
        switch (snapshots.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          default:
            return Column(
              children: makeListWidget(snapshots),
            );
        }
      },
    );
  }

  List<Widget> makeListWidget(AsyncSnapshot snapshots) {
    return snapshots.data.docs.map<Widget>((document) {
      return Card(
        child: ListTile(
          leading: Container(
              width: 100,
              child: Image.network(
                document['img'],
                fit: BoxFit.cover,
              )),
          title: Text(document['word_name']),
          subtitle: Text(document['type']),
        ),
      );
    }).toList();
  }
}
