import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:newsapppro/login/login_page.dart';
import 'package:newsapppro/views/homepage.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({super.key});

  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Text(
                      //   "Create",
                      //   style: TextStyle(
                      //       color: Colors.blue,
                      //       fontStyle: FontStyle.italic,
                      //       fontWeight: FontWeight.w900,
                      //       fontSize: 33),
                      // ),
                      // // SizedBox(
                      // //   width: 20,
                      // // ),
                      Text(
                        "Daily",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 33,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "News",
                        style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            fontSize: 33),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        // top: MediaQuery.of(context).size.height * 0.5,
                        right: 35,
                        left: 35),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Name",
                              // fillColor: Colors.grey.shade100,
                              filled: true,
                              prefixIcon: Icon(Icons.people),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              // fillColor: Colors.grey.shade100,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.mail,
                                // color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                // color: Colors.black,
                              ),
                              hintText: "Password",
                              // fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey.shade900,
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  // final FirebaseAuth _auth =
                                  //     FirebaseAuth.instance;
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then((value) {
                                    print("Created Account Successfully");
                                    const snackdemo = SnackBar(
                                      content: Text('Sucessfully'),
                                      backgroundColor: Colors.lightBlueAccent,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackdemo);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }).onError((error, stackTrace) {
                                    print("Error ${error.toString()}");
                                    const snackdemo = SnackBar(
                                      content: Text('failed'),
                                      backgroundColor: Colors.lightBlueAccent,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackdemo);
                                  });
                                  //   registration(_emailController.text,
                                  //       _passwordController.text);
                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.grey.shade800,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  registration(String email, String password) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
// Defining Register function
    register(emailAddr, pass) {
      _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((user) => print(user))
          .catchError((e) => print(e));
    }
  }
}
