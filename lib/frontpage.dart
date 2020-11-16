import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'order_details.dart';
class Frontpage extends StatefulWidget {


  @override
  _FrontpageState createState() => _FrontpageState();
}
class _FrontpageState extends State<Frontpage> {
  var emailId;

  Icon cusicon = Icon(Icons.search);
  Widget cussearchbar = Text('BOOKS');



  getMethod() async {
    String theUrl = 'https://designproject---eprint.000webhostapp.com/getData.php';
    var res = await http.get(
        Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);
    print(responseBody);
    return responseBody;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    print('user_name: $emailId');
  }

  void setValues(resId, nameOfBook, author, subject, noOfPages, price,
      url) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // set values
    sharedPrefs.setString('email', emailId);
    sharedPrefs.setString('res_id', resId);
    sharedPrefs.setString('name_of_book', nameOfBook);
    sharedPrefs.setString('author', author);
    sharedPrefs.setString('subject', subject);
    sharedPrefs.setString('no_of_pages', noOfPages);
    sharedPrefs.setString('price', price);
    sharedPrefs.setString('url', url);
    print('Values Set in Shared Prefs!!');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          brightness: Brightness.dark,

          title: Text("TEXTBOOKS AVAILABLE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

          backgroundColor: Colors.blueGrey[900],


        ),
       // drawer: MenuBar()


        body: FutureBuilder(
            future: getMethod(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List snap = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              }
              return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: Text("${snap[index]['NAME']}"),
                          subtitle: Text("${snap[index]['AUTHOR']}"),
                          //readurl="${snap[index]['URL']}",
                          onTap: () {
                            setState(() {
                              _launchInBrowser('${snap[index]['URL']}');
                            });
                          },

                          trailing: IconButton(
                              icon: Icon(Icons.print),
                              color: Colors.blueGrey,
                              onPressed: () {
                                setValues(
                                    "${snap[index]['ID']}",
                                    "${snap[index]['NAME']}",
                                    '${snap[index]['AUTHOR']}',
                                    '${snap[index]['SUBJECT']}',
                                    '${snap[index]['PAGES']}',
                                    '${snap[index]['PRICE']}',
                                    '${snap[index]['URL']}');
                                takeOrder("${snap[index]['SUBJECT']}",
                                    "${snap[index]['NAME']}",
                                    "${snap[index]['AUTHOR']}",
                                    "${snap[index]['PAGES']}"
                                    , "${snap[index]['PRICE']}");
                              }
                          )
                      ),
                    );
                  });
            }
        )
    );
  }

  void takeOrder(sub, book, auth, page, price) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          OrderDetails(subject: sub,
            nameOfBook: book,
            author: auth,
            noofpages: page,
            price: price,),
    ),);
  }

}




