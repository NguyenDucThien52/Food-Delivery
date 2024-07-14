import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Service/UserAPI.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/User.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Person> user;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late String password;

  late String imageURL;
  late String imageDatabase;

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Bạn đã cập nhật hồ sơ cá nhân thành công!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser!.email);
    user = UserService().getUser(FirebaseAuth.instance.currentUser!.email);
    user.then((value) {
      print("imageURL: ${value.imageURL}");
      _nameController.text = value.fullName!;
      _emailController.text = value.email!;
      _phoneController.text = value.phoneNumber!;
      _addressController.text = value.address;
      imageURL = value.imageURL;
      imageDatabase = value.imageURL;
      print(imageDatabase=="");
    });
    // imageURL = widget.user.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Thông tin cá nhân"),
        leading: IconButton(
            onPressed: () {
              if (imageURL != imageDatabase) {
                FirebaseStorage.instance.refFromURL(imageURL).delete();
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: FutureBuilder<Person>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("Không tìm  thấy thông tin người dùng"),
                );
              } else {
                print("URL: ${snapshot.data!.imageURL}");
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: GestureDetector(
                        onLongPress: () async {
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
                            if (imageURL != "") {
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
                        UserService().registerUser(Person(
                            fullName: _nameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneController.text,
                            address: _addressController.text,
                            imageURL: imageURL,
                        roles: "USER"));
                        if (imageDatabase!="") {
                          FirebaseStorage.instance.refFromURL(imageDatabase).delete();
                        }
                        imageDatabase = imageURL;
                        showSnackBar(context);
                      },
                      child: Text("Cập nhật tài khoản"),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
