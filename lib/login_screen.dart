import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colors.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _email, _password; //local variable

  void signin(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email!, password: _password!)
        .catchError((onError) {
      print(onError);
    }).then((authUser) {
      if (authUser.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Image.asset(
                      bgImage,
                      height: height * 0.40,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.50,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.3, 0.8],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.white])),
                      //color: Colors.grey.withOpacity(0.3),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              appName,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                //fontFamily: 'Indieflower'
                              ),
                            ),
                            Text(
                              slogan,
                              style: TextStyle(
                                color: Colors.grey[600],
                                letterSpacing: 2.0,
                                //fontFamily: 'Indieflower',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Container(
                    child: Text(
                      ' $LoginString ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primarycolor.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                        border: Border(
                            left: BorderSide(color: primarycolor, width: 5))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (email) {
                      if (email!.isEmpty)
                        return 'Please Enter email';
                      else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) return 'Its not a valid email';
                      //print(email);
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    //keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primarycolor)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: primarycolor,
                        ),
                        labelText: "EMAIL ADDRESS",
                        labelStyle:
                            TextStyle(color: primarycolor, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password!.isEmpty)
                        return 'please enter password';
                      else if (password.length < 8 || password.length > 15)
                        return "password must atleast 8 and atmost 15 character length";
                      //print(password);
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primarycolor)),
                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: primarycolor,
                        ),
                        labelText: "PASSWORD",
                        labelStyle:
                            TextStyle(color: primarycolor, fontSize: 16)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        Forget,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )),
                ),
                Center(
                    child: SizedBox(
                  height: height * 0.08,
                  width: width - 30,
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        signin(context);
                        print(_email);
                        print(_password);
                        // if (_email == 'swaminathan.it20@bitsathy.ac.in' &&
                        //     _password == "12345678") {
                        //   FocusScope.of(context).unfocus();
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomeScreen(),
                        //     ),
                        //   );
                        // } else {
                        //   print("invalid entry");
                        // }
                      }
                    },
                    child: Text(
                      'Login to Account',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: primarycolor,
                    ),
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: primarycolor, fontSize: 16.0),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
