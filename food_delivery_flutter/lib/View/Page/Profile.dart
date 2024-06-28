import 'dart:ui';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/UserAPI.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/User.dart';

class Profile extends StatefulWidget {
  final Person user;

  const Profile({required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late String imageURL;
  bool isUpdated = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.fullName;
    _emailController.text = widget.user.email;
    _phoneController.text = widget.user.phoneNumber;
    _addressController.text = widget.user.address;
    imageURL = widget.user.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Thông tin cá nhân"),
        leading: IconButton(
          onPressed: (){
            print(isUpdated);
            if(isUpdated){
              FirebaseStorage.instance.refFromURL(imageURL).delete();
            }
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: GestureDetector(
                  onLongPress: ()async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference reference = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = reference.child('images');
                    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                    try {
                      await referenceImageToUpload.putFile((File(image.path)));
                      imageURL = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      print(error.toString());
                    }
                    setState(() {
                      imageURL = imageURL;
                    });
                  },
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
                    if (image == null) return;
                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference reference = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = reference.child('images');
                    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                    try {
                      if(imageURL!="") {
                        FirebaseStorage.instance.refFromURL(imageURL).delete();
                      }
                        await referenceImageToUpload.putFile((File(image.path)));
                        imageURL = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      print(error.toString());
                    }
                    setState(() {
                      imageURL = imageURL;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                      imageURL == ""
                          ? "https://firebasestorage.googleapis.com/v0/b/food-delivery-18948.appspot.com/o/user-circle.511x512.png?alt=media&token=45139d47-bce4-4c61-abce-e5746e89b6e5"
                          : imageURL,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      labelText: "Email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: "Tên",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: "Số điện thoại",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: "Địa chỉ",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  isUpdated = true;
                  UserService().registerUser(Person(
                      fullName: _nameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      address: _addressController.text,
                      imageURL: imageURL));
                },
                child: Text("Cập nhật tài khoản"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
