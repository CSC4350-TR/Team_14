import 'package:file_picker/file_picker.dart';
import 'package:social_app/forms/loginform.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/storage_service.dart';
import 'package:social_app/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/widgets/image_password.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DatabaseService _db;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  int _index = -1;
  List<String> Images = [
  ];
  List<int> chosenImageArray = [-1,-1,-1,-1,-1,-1,-1,-1];
  List<int> patternPassword = [];
  _RegisterFormState() {
    _db = DatabaseService();
    _db.passwordImages!.listen((event) {
      setState(() {
        Images = event;
        Images.shuffle();
      });
    });
  }


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
    final Storage storage = Storage();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Positioned(
              top: 50,
              child: SizedBox(
                  height: 120,
                  width: 200,
                  child: Image.asset(
                    'assets/images/spongebob.png',
                  ))),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Social Zone",
                style: TextStyle(fontSize: 40, fontFamily: "Signatra"),
              )
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 18),
            TextFormField(
              controller: _email,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email cannot be empty";
                }
                if (!value.contains('@')) {
                  return "Email in wrong format";
                }
                return null;
              },
            ),
            TextFormField(
              textAlign: TextAlign.center,
              controller: _username,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter the name you want your friends to see'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username cannot be empty";
                }
                return null;
              },
            ),
            Text(
              "Please select 4 images in a sequence of your choice",
              style: TextStyle(fontSize: 15, fontFamily: "Signatra"),
            ),

            fun_PasswordImages(chosenImageArray, Images, callBack),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                    register();
                  });
                },
                child: const Text("REGISTER")),
            verticalSpaceSmall,
            TextButton(
                onPressed: showLogin,
                child: const Text(
                  'Already have an account? Log in here.',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                )),
          ]),
        ],
      ),
    );
  }

  Future<void> register() async {
    print("chosen images");
    print(patternPassword);
    List<String> password = [];
    int count = 0;
    for(var item in patternPassword){
      if( item != -1){
        password.add(Images[item][Images[item].length-2]+Images[item][Images[item].length-1]);
      }
      count++;
    }
    print("the password");
    print(password);
    print(Images);
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential registerResponse =
            await _auth.createUserWithEmailAndPassword(
                email: _email.text, password: password.toString());

        registerResponse.user!.updateDisplayName(_username.text);

        _db
            .setUser(registerResponse.user!.uid, _username.text, _email.text,
                _bio.text)
            .then((value) => snackBar(context, "User registered successfully."))
            .catchError((error) => snackBar(context, "FAILED. $error"));

        registerResponse.user!.sendEmailVerification();
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          snackBar(context, e.toString());
          loading = false;
        });
      }
    }
  }

  void showLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LogInForm()));

  }
}
