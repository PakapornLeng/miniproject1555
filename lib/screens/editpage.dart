import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/screens/cattype.dart';
import 'package:firebasedemo/screens/dogtype.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String docid;

  const EditPage({Key key, this.docid}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _foodController = TextEditingController();
  // TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    //var _controller1;
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        title: Text('Edit information'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _foodController,
              decoration: InputDecoration(
                  labelText: 'Name Breed',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide())),
            ),
          ),
          // Container(
          //   child: TextField(
          //     controller: _controller2,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _controller3,
              decoration: InputDecoration(
                  labelText: 'type',
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide())),
            ),
          ),
          RaisedButton(
            onPressed: () {
              updateFood();
            },
            child: Text("SAVE"),
          ),
          Text(" "),
          Text(" "),
          Text("if you want to see type of animals click below button"),
          Text(" "),
          Container(
            child: RaisedButton(
              color: Colors.yellow[700],
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Cattype(),
                );
                Navigator.push(context, route);
              },
              child: Text("CAT"),
            ),
          ),
          Container(
            child: RaisedButton(
              color: Colors.yellow[700],
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Dogtype(),
                );
                Navigator.push(context, route);
              },
              child: Text("DOG"),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getInfo() async {
    await FirebaseFirestore.instance
        .collection("words")
        .doc(widget.docid)
        .get()
        .then((value) {
      setState(() {
        //ค่ามันเปลี่ยนเลยต้อง setstate
        _foodController =
            TextEditingController(text: value.data()['word_name']);
        // _controller2 =
        //     TextEditingController(text: value.data()['price'].toString());
        _controller3 = TextEditingController(text: value.data()['type']);
      });
    });
  }

  Future<void> updateFood() async {
    await FirebaseFirestore.instance
        .collection("foods")
        .doc(widget.docid)
        .update({
      'food_name': _foodController.text,
      // 'price': int.parse(_controller2.text),
      'type': _controller3.text,
    }).whenComplete(() => Navigator.pop(context));
  }
}
