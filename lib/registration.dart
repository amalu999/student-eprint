import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {



  bool signin = true;

  TextEditingController namectrl,emailctrl,passctrl,phnctrl,admission_noctrl;

  bool processing = false;

  void setValues(email) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // set values

    sharedPrefs.setString('email', email);
    print('Values Set in Shared Prefs!!');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    phnctrl = new TextEditingController();
    admission_noctrl = new TextEditingController();




  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Icon(Icons.account_circle,size: 200,color: Colors.white,),

                boxUi(),
              ],
            ),
          )
      ),
    );
  }

  void changeState(){
    if(signin){
      setState(() {
        signin = false;

      });
    }else
      setState(() {
        signin = true;

      });
  }
  void registerUser() async{

    setState(() {
      processing = true;
    });
    var url = "https://designproject---eprint.000webhostapp.com/signup.php";
    var data = {
      "email":emailctrl.text,
      "name":namectrl.text,
      "pass":passctrl.text,
      "phn":phnctrl.text,
      "admission_no":admission_noctrl.text,


    };

    var res = await http.post(url,body:data);

    if(jsonDecode(res.body) == "account already exists"){
      Fluttertoast.showToast(msg: "account exists, Please login",toastLength: Toast.LENGTH_SHORT);

    }else{

      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
      }else{
        Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
      //////////////

    });
  }

  void userSignIn() async{
    setState(() {
      processing = true;
    });

    var url = "https://designproject---eprint.000webhostapp.com/signin.php";
    var data = {
      "email":emailctrl.text,
      "pass":passctrl.text,
    };

    var res = await http.post(url,body:data);

    if(jsonDecode(res.body) == "dont have an account"){
      Fluttertoast.showToast(msg: "dont have an account,Create an account",toastLength: Toast.LENGTH_SHORT);
    }
    else{
      if(jsonDecode(res.body) == "false"){
        Fluttertoast.showToast(msg: "incorrect password",toastLength: Toast.LENGTH_SHORT);
      }
      else{
        if(jsonDecode(res.body) == "true"){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),);
       }
        else{Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);}
      }}

    setState(() {
      processing = false;
      setValues(emailctrl.text);
    });
  }



  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.blue : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),
              ],
            ),

            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            TextField(
              controller: emailctrl,
              decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
                  hintText: 'email'),
              keyboardType: TextInputType.emailAddress,
            ),


            TextField(
              controller: passctrl,

              decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
                  hintText: 'pass'),
              keyboardType: TextInputType.visiblePassword,

            ),


            SizedBox(height: 10.0,),

            MaterialButton(
                onPressed:() => userSignIn(),
                child: processing == false ? Text('Sign In',
                  style: GoogleFonts.varelaRound(fontSize: 18.0,
                      color: Colors.blue),) : CircularProgressIndicator(backgroundColor: Colors.red,)

            ),

          ],
        ),
      ),
    );
  }

  Widget signUpUi(){
    return Column(
      children: <Widget>[



        TextField(
          controller: emailctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'email'),
          keyboardType: TextInputType.emailAddress,
        ),

        TextField(
          controller: namectrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'name'),
        ),

        TextField(
          controller: passctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'pass'),
          keyboardType: TextInputType.visiblePassword,
        ),
        TextField(
            controller: phnctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.phone,),
                hintText: 'phone'),
            keyboardType: TextInputType.phone
        ),
        TextField(
          controller: admission_noctrl,
          decoration: InputDecoration(prefixIcon: Icon(Icons.info,),
              hintText: 'admission no'),
        ),
        SizedBox(height: 10.0,),

        MaterialButton(
            onPressed:() => registerUser(),
            child: processing == false ? Text('Sign Up',
              style: GoogleFonts.varelaRound(fontSize: 18.0,
                  color: Colors.blue),) : CircularProgressIndicator(backgroundColor: Colors.red)
        ),

      ],
    );
  }

// now we will setup php and database
//thank you
}