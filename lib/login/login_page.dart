import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:newsapppro/login/register.dart';
import 'package:newsapppro/views/homepage.dart';

class MyLoginAppPage extends StatefulWidget {
  const MyLoginAppPage({super.key});

  @override
  State<MyLoginAppPage> createState() => _MyLoginAppPageState();
}

class _MyLoginAppPageState extends State<MyLoginAppPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        print("No User Found for that email");
      }
    }
    return user;
  }

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                      Text(
                        "Welcome to",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                            fontSize: 33),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        " Daily",
                        style: TextStyle(
                          // color: Colors.black87,
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
                          keyboardType: TextInputType.visiblePassword,

                          // obscureText: true,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              // color: Colors.black,
                            ),
                            // suffixIcon: IconButton(
                            //   icon: Icon(passwordVisible
                            //       ? Icons.visibility
                            //       : Icons.visibility_off),
                            //   onPressed: () {
                            //     setState(
                            //       () {
                            //         passwordVisible = !passwordVisible;
                            //       },
                            //     );
                            //   },
                            // ),
                            alignLabelWithHint: false,
                            // filled: true
                            hintText: "Password",
                            // fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => NewRegister()));
                                },
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey.shade900,
                              child: IconButton(
                                // color: Colors.white,
                                onPressed: () async {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then((value) {
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

                                  // User? user = await loginUsingEmailPassword(
                                  //     email: _emailController.text,
                                  //     password: _passwordController.text,
                                  //     context: context);
                                  // print(user);
                                  // if (user != null) {
                                  // ignore: use_build_context_synchronously

                                  // }
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Don't have account?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                // color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewRegister()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20,
                                    // color: Colors.grey.shade900,
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
}

void snackBar() {}

class snackBarDemo extends StatelessWidget {
  const snackBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () {
          const snackdemo = SnackBar(
            content: Text('Hii this is GFG\'s SnackBar'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        },
        child: const Text('Click Here'),
      ),
    );
  }
}
