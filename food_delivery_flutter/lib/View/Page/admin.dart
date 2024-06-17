// import 'dart:io';
// import 'dart:math';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:food_delivery/Model/Product.dart';
// import 'package:food_delivery/Service/ProductAPI.dart';
// import 'package:image_picker/image_picker.dart';
//
// class admin extends StatelessWidget {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();
//   TextEditingController _priceController = TextEditingController();
//   String imageURL = '';
//   final ProductService product = ProductService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add product"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Name"),
//           TextFormField(controller: _nameController),
//           Text("Description"),
//           TextFormField(controller: _descriptionController),
//           Text("Price"),
//           TextFormField(controller: _priceController),
//           IconButton(
//             onPressed: () async {
//               ImagePicker imagePicker = ImagePicker();
//               XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
//               if (image == null) return;
//               String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//               print('Picked image path: ${image.path}');
//               Reference reference = FirebaseStorage.instance.ref();
//               Reference referenceDirImages = reference.child('images');
//               Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
//               try {
//                 await referenceImageToUpload.putFile((File(image.path)));
//                 imageURL = await referenceImageToUpload.getDownloadURL();
//               } catch (error) {
//                 print(error.toString());
//               }
//             },
//             icon: Icon(Icons.camera_alt),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               ImagePicker imagePicker = ImagePicker();
//               XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
//               if (image == null) return;
//               String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//               print('Picked image path: ${image.path}');
//               Reference reference = FirebaseStorage.instance.ref();
//               Reference referenceDirImages = reference.child('images');
//               Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
//               try {
//                 await referenceImageToUpload.putFile((File(image.path)));
//                 imageURL = await referenceImageToUpload.getDownloadURL();
//               } catch (error) {
//                 print(error.toString());
//               }
//             },
//             child: Text("Chọn ảnh"),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 product.insertProducts(
//                   Product(
//                     name: _nameController.text,
//                     description: _descriptionController.text,
//                     price: double.parse(_priceController.text),
//                     imageURL: imageURL,
//                   ),
//                 );
//               },
//               child: Text("Submit"))
//         ],
//       ),
//     );
//   }
// }
