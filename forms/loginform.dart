import 'package:social_app/pages/home.dart';
import 'package:social_app/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/widgets/image_password.dart';

import '../services/database.dart';
import '../widgets/loading.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({

    Key? key,
  }) : super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  var form = GlobalKey<FormState>();
  var loading = false;
  var email = TextEditingController();
  var password = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late DatabaseService _db;
  _LogInFormState() {
    _db = DatabaseService();
    _db.passwordImages!.listen((event) {
      setState(() {
        Images = event;
        Images.shuffle();
      });
    });
  }

  List<String> Images = [
  ];
  List<int> chosenImageArray = [-1,-1,-1,-1,-1,-1,-1,-1];
  List<int> patternPassword = [];
  callBack(int index) {

    setState(() {
      int count = 0;
      for (int i in chosenImageArray){
        if(i != -1){
          count++;
        }
      }
      if(count == 4){
        count = 0;
        for (int i in chosenImageArray) {
          chosenImageArray [ count] = -1;
          count++;
        }
        patternPassword = [];

      }
      if(chosenImageArray[index] != -1){
        chosenImageArray [index] = -1;
        for(int i = 0; i<patternPassword.length; i++){
          if(index == patternPassword[i]){
            patternPassword.remove(i);
          }
        }
      }else{
        chosenImageArray [index] = index;
        patternPassword.add(index);
      }




    });

  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        :Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.teal, Colors.purple])),
    child:Scaffold(
      backgroundColor: Colors.transparent,

          body: Center(

            child: Form(
                key: form,
                child:

                Column(


                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Positioned(
                        top: 50,
                        child: SizedBox(
                            height: 120,
                            width: 200,
                            child: Image.asset(
                              'assets/images/spongebob.png',
                            ))),
                    Text(
                      "Login for the good stuff!!",
                      style: TextStyle(fontSize: 40, fontFamily: "Signatra"),
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter valid email address'),
                      textInputAction: TextInputAction.next, // Moves focus to next.
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Email must have a value.";
                        } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/="
                                "?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Email in the wrong format.";
                        }
                        return null;
                      },
                    ),
                    verticalSpaceSmall,
                    fun_PasswordImages(chosenImageArray, Images, callBack),

                    verticalSpaceSmall,
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                            logIn();
                          });
                        },
                        child: const Text("Log In")),
                    verticalSpaceSmall,
                    TextButton(
                      onPressed: forgotPassword,
                      child: const Text(
                        'Forgot Password? Click Here',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    verticalSpaceLarge
                  ],
                ),
              ),
          ),
        ));
  }

  void logIn() async {
    List<String> password = [];
    int count = 0;
    print("chosen images");
    print(patternPassword);
    for(var item in patternPassword){
      if( item != -1){
        password.add(Images[item][Images[item].length-2]+Images[item][Images[item].length-1]);
      }
      count++;
    }
    print("the password");
    print(password);
    print(Images);
    if (form.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.toString());
        setState(() {
          loading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          snackBar(context, 'The email/password combination is incorrect.');
        } else {
          snackBar(context, e.message ?? "Authentication error.");
        }
        setState(() {
          loading = false;
        });
      } catch (e) {
        snackBar(context, e.toString());
        setState(() {
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void forgotPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: email.text);
      snackBar(context, "Password reset email sent.");
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message ?? "Authentication error.");
    } catch (e) {
      snackBar(context, e.toString());
    }

    setState(() {
      loading = false;
    });
  }
}
