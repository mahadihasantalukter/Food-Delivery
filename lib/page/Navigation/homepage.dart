import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/page/Auth_service/auth_service.dart';

class Nav_homepage extends StatefulWidget {
  const Nav_homepage({super.key});

  @override
  State<Nav_homepage> createState() => _Nav_homepageState();
}

class _Nav_homepageState extends State<Nav_homepage> {
  final CollectionReference productsRef = FirebaseFirestore.instance.collection(
    'products',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: productsRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final List<Product> products =
              snapshot.data!.docs.map((doc) {
                return Product.fromFirebase(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                );
              }).toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = snapshot.data!.docs[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text(product['description']),
                trailing: Text(product['price'].toString()),
              );
            },
          );
        },
      ),
    );
  }
}
