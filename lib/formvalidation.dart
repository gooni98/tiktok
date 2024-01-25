import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class formValidation extends StatefulWidget {
  const formValidation({super.key});

  @override
  State<formValidation> createState() => _formValidationState();
}

class _formValidationState extends State<formValidation> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String email = "";
  String password = "";
  void handleSignUp() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("user registered: ${userCredential.user!.email}");
    } catch (e) {
      print("Error During Registration: $e");
    }
  }

  void handleSignIn() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("user logged in: ${userCredential.user?.email}");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => assignment1()));
    } catch (e) {
      print("Error during login: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Validation"),
      ),
      body: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email is required";
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Email", border: OutlineInputBorder()),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password is required";
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState?.validate() ?? false)
                        handleSignUp();
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState?.validate() ?? false)
                        handleSignIn();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          )),
    );
  }
}
