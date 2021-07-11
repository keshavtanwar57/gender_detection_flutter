import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Model extends StatefulWidget {
  @override
  _ModelState createState() => _ModelState();
}

class _ModelState extends State<Model> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Gender Detection'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: _loading
                  ? Container(
                      alignment: Alignment.center,
                      child: Lottie.network(
                          'https://assets1.lottiefiles.com/packages/lf20_OdNgAj.json'),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/1.json'),
                          SizedBox(
                            height: 30,
                          ),
                          Text('Click or Select a Picture'),
                          _image == null
                              ? Container()
                              : Expanded(child: Image.file(_image)),
                          SizedBox(
                            height: 20,
                          ),
                          _outputs != null
                              ? Text(
                                  "${_outputs[0]["label"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    background: Paint()..color = Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                    color: Colors.lightBlue,
                    onPressed: pickCameraImage,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000)),
                    splashColor: Colors.teal,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(Icons.camera_alt, size: 30))),
                SizedBox(
                  width: 20,
                ),
                FlatButton(
                    color: Colors.lightBlue,
                    onPressed: pickGalleryImage,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000)),
                    splashColor: Colors.teal,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(
                          Icons.photo,
                          size: 30,
                        )))
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'by Keshav Tanwar',
              style: TextStyle(color: Colors.white54),
            ),

          ],
        ),
      ),
    );
  }

  pickCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  pickGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
