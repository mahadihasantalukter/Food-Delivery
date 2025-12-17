// ignore_for_file: dead_code

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _discountController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // ignore: unused_element
  Future<void> _uploadImage() async {
    if (_image != null || _nameController.text.isNotEmpty) {
      {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select an image')));
        return;
      }
      setState(() {
        _isLoading = true;
      });
      // ignore: unused_local_variable
      final double price = double.tryParse(_priceController.text) ?? 0.0;
      final num discount = num.tryParse(_discountController.text) ?? 0;
      try {
        String url_data = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref().child(
          'admin_upload/$url_data',
        );
        UploadTask uploadTask = reference.putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('admin_upload').add({
          'name': _nameController.text,
          'description': _descController.text,
          'price': _priceController.text,
          'imageUrl': downloadUrl,
          'discount': discount,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(('upload failed $e'))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 85, 18),
              Color.fromARGB(255, 2, 41, 53),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter, 
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Upload Product",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Product name",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descController,
                decoration: InputDecoration(
                  hintText: "discription",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.description, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: "price",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              SizedBox(height: 16),
              _image == null
                  ? Text(
                    "No image selected",
                    style: TextStyle(color: Colors.white54),
                  )
                  : Image.file(_image!),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 235, 182, 8),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.upload),
                label: const Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
