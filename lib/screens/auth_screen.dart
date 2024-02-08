import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userName = "";
  var _enteredEmail = "";
  var _enteredPassword = "";
  File? _selectedImage;

  var _isLogin = true;
  var _isAuthenticated = false;

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (_isLogin.toString().trim().isEmpty ||
        isValid.toString().trim().isEmpty) {
      setState(() {
        _isAuthenticated = false;
      });
    } else {
      _formKey.currentState!.save();
      setState(() {
        _isAuthenticated = true;
      });
      try {
        if (_isLogin == true) {
          /////////////////////this is for signIn/////////////////
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);
        } else {
          ////////////////////this is for createUser////////////////
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          ///////////////////this is for storage////////////////////////
          final storageRef = FirebaseStorage.instance
              .ref()
              .child("user-Image")
              .child("${credential.user!.uid}.jpg");
          await storageRef.putFile(_selectedImage!);
          final imageUrl = await storageRef.getDownloadURL();
          //////////////this is for cloud_storage/////////////////
          await FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
            'userName': _userName,
            'email': _enteredEmail,
            'password': _enteredPassword,
            'imageUrl': imageUrl
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Authentication failed'),
          ),
        );
      } catch (e) {
        print(e);
      }
    }
    if (mounted) {
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentication Screen")),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 20, right: 20),
                  width: 200,
                  child: Image.asset("assets/images/chat.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.blueGrey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_isLogin == false)
                              UserImagePicker(
                                onPickImage: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "User Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.length < 5) {
                                    return "please enter a valid user name";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {
                                  _userName = newValue!;
                                },
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              onSaved: (newValue) {
                                _enteredEmail = newValue!;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return "please enter a valid email address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              obscureText: true,
                              onSaved: (newValue) {
                                _enteredPassword = newValue!;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.length < 7) {
                                  return "Password must be at least 7 characters long";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isAuthenticated)
                                  const CircularProgressIndicator(),
                                if (!_isAuthenticated)
                                  ElevatedButton(
                                    onPressed: _submit,
                                    child: Text(_isLogin ? "Login" : "SignUp"),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(_isLogin
                                      ? 'Create an account'
                                      : 'I have already an account'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
