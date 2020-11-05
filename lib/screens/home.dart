//import 'dart:html';
//import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'insert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/screens/editpage.dart';
import 'package:firebasedemo/screens/insert.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String user;
  String password;
  String name;
  String tel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" PETS For You ")),
      // ignore: missing_required_param
      body: realTimeFood(),

      backgroundColor: Colors.yellow.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route1 =
              MaterialPageRoute(builder: (context) => InsertPage());
          Navigator.push(context, route1);
        },
        //tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget realTimeFood() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("words").snapshots(),
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
        //---------ใส่Crad รูปภาพ
        child: ListTile(
          trailing: IconButton(
              //--------trailing คือ เพิ่มข้างหลัง เพื่อไว้ใส่ icon ลบ
              icon: Icon(Icons.delete),
              //----------ปุ่มลบ-----------
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text("ต้องการลบข้อมูลหรือไม่"),
                            )
                          ],
                        ),
                        actions: [
                          FlatButton(
                              child: Text("ลบ"),
                              color: Colors.red,
                              onPressed: () {
                                deleteFood(
                                    document.id); //-------ใส่ document id
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text("ยกเลิก"),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    });
              }),
          leading: Container(
            width: 60,
            child: Image.network(
              document['img'],
              fit: BoxFit.cover,
            ),
          ),
          title: Text(document['word_name']),
          subtitle: Text(document['type'].toString()),
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => EditPage(docid: document.id),
            );
            Navigator.push(context, route);
          },
        ),
      );
    }).toList();
  }

  Future<void> deleteFood(id) async {
    await FirebaseFirestore.instance.collection("words").doc(id).delete();
  }

  cattype() {}
}
