import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> _saveData(String name, String description, String imageUrl) async {
  try {
   
    await FirebaseFirestore.instance.collection('users').add({
      'Price'
      'name': name,
      'description': description,
      'imageUrl': imageUrl, 
      'timestamp': FieldValue.serverTimestamp(),
    });
    print('Data saved successfully!');
  } catch (e) {
    print('Data saving failed: $e');
  }
}