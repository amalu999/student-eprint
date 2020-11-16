import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


class ConfirmcOrder extends StatefulWidget {
  final subject;
  final nameOfBook;
  final author;
  final int beg;
  final int end;
  final int copies;

  const ConfirmcOrder({Key key, this.subject, this.nameOfBook, this.author, this.beg, this.end, this.copies}) : super(key: key);


  @override
  _ConfirmcOrderState createState() => _ConfirmcOrderState();
}

class _ConfirmcOrderState extends State<ConfirmcOrder> {

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
  var beg;
  var rate;

  var end;

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
    beg = sharedPrefs.get('beg');
    end = sharedPrefs.get('end');
    print('user_name: $emailId');
    print('user_name: $copies');
    print('user_name: $beg');
    print('user_name: $end');
  }

  void corderplacing() async {
    setState(() {
      processing = true;
    });
    var url = "https://designproject---eprint.000webhostapp.com/custom_order.php";
    var data = {
      "resid": resId,
      "email": emailId,
      "copies": copies,
      "beg": beg,
      "end": end,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "false") {
      Fluttertoast.showToast(msg: "failed", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "order placed", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
      }
    }

    setState(() {
      processing = false;
    });}
  getMethod() async{
    String theUrl='https://designproject---eprint.000webhostapp.com/getrate.php';
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    if(res.statusCode==200){
      rate=json.decode(res.body)[0]['RATE'];
      print(rate);}else{print('error');}
    // return responseBody;

  }
  @override
  void initState() {
    super.initState();
    getValues();
    getMethod();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        brightness: Brightness.dark,

        title: Text("READY TO PLACE ORDER  ?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "RANGE:   ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                    children: [
                      TextSpan(text: widget.beg.toString()+"-"+widget.end.toString(),style: TextStyle(
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
                    text: "RATE:   ",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                    children: [
                      TextSpan(text: rate.toString(),style: TextStyle(
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
                      TextSpan(text: ((int.parse(widget.end.toString())-int.parse(widget.beg.toString())+1)*double.parse(rate.toString())).toString(),style: TextStyle(
                          fontWeight: FontWeight.normal,color: Colors.blueGrey
                      ))
                    ]
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  child: Text("CONFIRM"),
                  color: Colors.blueGrey,
                  onPressed: () {
                    corderplacing();
                  }


              ),
            ),
          ],),
      ),


    );
  }


}
