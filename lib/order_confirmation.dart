  import 'package:flutter/material.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:fluttertoast/fluttertoast.dart';


  class ConfirmOrder extends StatefulWidget{
  final String subject;
  final String nameOfBook;
  final String author;

  final noofpages;
  final  price;
  final int copies;
  final amount;
  const ConfirmOrder({Key key, this.subject, this.nameOfBook, this.author, this.noofpages, this.price, this.copies, this.amount}) : super(key: key);



  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
  }

  class _ConfirmOrderState extends State<ConfirmOrder> {


  bool processing = false;
  var emailId;
  var resId;
  var name;
  var author;
  var subject;
  var nopages;
  var price;
  var url;
  var copies;
  int p;


  void getValues() async {
  print('Getting Values from shared Preferences');
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  emailId = sharedPrefs.getString('email');
  name = sharedPrefs.getString('name_of_book');
  author = sharedPrefs.getString('author');
  subject = sharedPrefs.getString('subject');
  nopages = sharedPrefs.getString('no_of_pages');
  price = sharedPrefs.getString('price');
  url = sharedPrefs.getString('url');
  resId = sharedPrefs.getString('res_id');
  copies = sharedPrefs.get('copies');
  print('user_name: $emailId');
  print('user_name: $copies');
  }
  @override
  void initState() {
  super.initState();
  getValues();
  }

  void orderplacing() async {
  setState(() {
  processing = true;
  });
  var url = "https://designproject---eprint.000webhostapp.com/order.php";
  var data = {
  "resid": resId,
  "email": emailId,
  "copies": copies,
  };

  var res = await http.post(url, body: data);

  if (jsonDecode(res.body) == "false") {
  Fluttertoast.showToast(msg: "failed", toastLength: Toast.LENGTH_SHORT);
  } else {
  if (jsonDecode(res.body) == "true") {
  Fluttertoast.showToast(
  msg: "order placed", toastLength: Toast.LENGTH_SHORT);
  } else {
  if (jsonDecode(res.body) == "true") {
  Fluttertoast.showToast(
  msg: "order placed", toastLength: Toast.LENGTH_SHORT);
  } else {
  if (jsonDecode(res.body) == "not a number") {
  Fluttertoast.showToast(
  msg: "enter a number", toastLength: Toast.LENGTH_SHORT);
  } else {
  if (jsonDecode(res.body) == "invalid resource") {
  Fluttertoast.showToast(
  msg: "invalid resource", toastLength: Toast.LENGTH_SHORT);
  } else {
  if (jsonDecode(res.body) == "invalid user") {
  Fluttertoast.showToast(
  msg: "invalid user", toastLength: Toast.LENGTH_SHORT);
  } else {
  Fluttertoast.showToast(
  msg: "error", toastLength: Toast.LENGTH_SHORT);
  }
  }
  }
  }
  }
  }
  setState(() {
  processing = false;
  });
  }

  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      brightness: Brightness.dark,

      title: Text("READY TO PRINT  ?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      backgroundColor: Colors.blueGrey[900],


    ),
  body: Container(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "SUBJECT:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: widget.subject,style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),
    SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "NAME OF BOOK:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: widget.nameOfBook,style: TextStyle(
                  fontWeight: FontWeight.normal,color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),

    SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "AUTHOR:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: widget.author,style: TextStyle(
                  fontWeight: FontWeight.normal,color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),

 /* Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text("NO OF PAGES:",style: Theme.of(context)
      .textTheme
      .headline5
      .copyWith(fontWeight: FontWeight.bold)),
  ),

  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(widget.noofpages),
  ),*/
    SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "PRICE:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: widget.price,style: TextStyle(
                  fontWeight: FontWeight.normal,color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),
    SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "COPIES:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: widget.copies.toString(),style: TextStyle(
                  fontWeight: FontWeight.normal,color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),
    SizedBox(height: 20,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            text: "AMOUNT:   ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
            children: [
              TextSpan(text: ((int.parse(widget.price))*int.parse(widget.copies.toString())).toString(),style: TextStyle(
                  fontWeight: FontWeight.normal,color: Colors.blueGrey
              ))
            ]
        ),
      ),
    ),

  Row(children: <Widget>[
  SizedBox(height: 30,width: 20),

  Row(children: <Widget>[
  SizedBox(height: 30,width: 20),
  Center(
    child: RaisedButton(
    child: Center(child: Text("CONFIRM")),
        color: Colors.blueGrey,
    onPressed:(){orderplacing();}



    ),
  ),
  ],
  ),

  ],
  ),
  ],),
  ),
  );
  }}