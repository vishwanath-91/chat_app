import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = "";
  var _enteredPassword = "";

  var _isLogin = true;

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      print(_enteredEmail);
      print(_enteredPassword);
    }
    if (_isLogin) {
      //login users.
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
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
