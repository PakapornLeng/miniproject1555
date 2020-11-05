//import 'dart:ffi';
import 'dart:io';
//import 'package:firebasedemo/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  TextEditingController _foodController = TextEditingController();
  //TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  // Future<void> chooseImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var _controller2;
    // var _controller3;
    // var _foodController;
    return Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(
          title: Text("Add Breed"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                child: RaisedButton(
                  onPressed: () {
                    chooseImage();
                  },
                  child: Text('Choose Image'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                width: 200,
                height: 200,
                child: _image == null ? Text(' No Image') : Image.file(_image),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _foodController,
                  decoration: InputDecoration(
                      labelText: 'Name Breed',
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide())),

                  //style: Text(Border),
                ),
              ),
              // Container(
              //   child: TextField(
              //     controller: _controller2,
              //     decoration: InputDecoration(
              //         labelText: 'ราคา',
              //         border: new OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(50.0),
              //             borderSide: new BorderSide())),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller3,
                  decoration: InputDecoration(
                      labelText: 'Type',
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide())),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  insertFood();

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
                              //child: Text("ต้องการบันทึกข้อมูลใช่หรือไม่"),
                              child:
                                  Text("Do you want to save the information?"),
                            ),
                          ],
                        ),
                        actions: [
                          FlatButton(
                              child: Text("์NO"),
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text("YES"),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    },
                  );
                },
                child: Text("Add"),
              )
            ],
          ),
        ));
  }

  Future<void> insertFood() async {
    String fileName = Path.basename(_image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask storageUploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) async {
      await FirebaseFirestore.instance.collection('words').add({
        'word_name': _foodController.text,
        // 'price': int.parse(_controller2.text),
        'type': _controller3.text,
        'img': value,
      }).whenComplete(() => Navigator.pop(context));
    });
  }

  Future<void> chooseImage() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('ยังไม่ได้อัพโหลดรูปภาพ');
      }
    });
  }
}
