import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  Uint8List? _image;
  File? selectedIMage;
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(top: 30),
      child: Center(
        child: Column(children: [
          Center(
            heightFactor: 1.5,
            widthFactor: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.center ,
              children: [Stack(
                children: <Widget>[
                  _image != null ?
                  CircleAvatar(
                    maxRadius: 60,
                    minRadius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: MemoryImage(_image!),
                  ) : 
                  const CircleAvatar(
                    maxRadius: 60,
                    minRadius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/cs_icon.png'),
                  ),
                  Positioned(
                    bottom: -0,
                    left: 75,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 39,
                        width: 39,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: (){
                            showImageOptionPickerOption(context);
                          }, 
                          icon: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                  ),
                ]
              ),]
            ),
          ),
          Text('Jesús Miguel Cerda González', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),),
          Divider(),
          ListTile(
            onTap: (){},
            title: Text('Email'),
            subtitle: Text('19030443@itcelaya.edu.mx'),
            leading: Icon(Icons.email),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            onTap: (){},
            title: Text('Phone'),
            subtitle: Text('461 191 5568'),
            leading: Icon(Icons.phone),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            onTap: (){},
            title: Text('Github'),
            subtitle: Text('@MIGU3TR0N'),
            leading: Icon(Icons.web_asset),
            trailing: Icon(Icons.chevron_right),
          ),
        ]),
      ),
    );
  }
  void showImageOptionPickerOption(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.deepOrangeAccent,
      context: context, 
      builder: (builder){
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/6,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickImageFromGallery(context);
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.image, size: 70,),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      _pickImageFromCamera(context);
                      setState(){}
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 70,),
                          Text('Camera'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  Future _pickImageFromGallery(BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState() {
        _image = File(returnImage.path).readAsBytesSync();
        selectedIMage = File(returnImage.path);
      }
    }
    Navigator.of(context).pop();
  }
  Future _pickImageFromCamera(BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      setState() {
        _image = File(returnImage.path).readAsBytesSync();
        selectedIMage = File(returnImage.path);
      }
    }
    Navigator.of(context).pop();
  }
}