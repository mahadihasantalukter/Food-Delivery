import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/page/wrapper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var isobscure = true.obs;
  Signup() async {
    // Using a try-catch block for robust error handling
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
    Get.offAll(Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 31, 61, 7),
              Color.fromARGB(255, 3, 0, 3),
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
                "Signup with Your Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Your name",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
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
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
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
              Obx(
                () => TextField(
                  obscureText: isobscure.value,

                  controller: passwordController,
                  decoration: InputDecoration(
                    suffixIcon: Obx(
                      () => GestureDetector(
                        onTap: () {
                          isobscure.value = !isobscure.value;
                        },
                        child: Icon(
                          isobscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),

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
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Signup();
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
