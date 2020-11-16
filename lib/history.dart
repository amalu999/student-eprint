import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:expansion_card/expansion_card.dart';

class YourHistory extends StatefulWidget {

  @override
  _YourHistoryState createState() => _YourHistoryState();
}

class _YourHistoryState extends State<YourHistory> with AutomaticKeepAliveClientMixin<YourHistory>{

  String email;
  var responseBody;



  getMethod1() async{
    Future <String> getValues() async {
      print('Getting Values from shared Preferences');
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      email = sharedPrefs.getString('email');
      print('user_namehello: $email');
      return email;



    }
    getValues();
    print(email);
    print("helloooo");

    var id='devikathazhath@gmail.com';
    var res = await http.get(Uri.encodeFull('https://designproject---eprint.000webhostapp.com/studenthistorydisplay.php?email='+email),headers: {"Accept":"application/json"});
    if(res.statusCode==200){responseBody=json.decode(res.body);print(responseBody);}
    else{print("Booooom");}
    return responseBody;

  }
  getMethod2() async{
    Future <String> getValues() async {
      print('Getting Values from shared Preferences');
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      email = sharedPrefs.getString('email');
      print('user_namehello: $email');
      return email;


    }
    print(email);
    getValues();
    var res = await http.get(Uri.encodeFull('https://designproject---eprint.000webhostapp.com/student_pages_history_display.php?email='+email),headers: {"Accept":"application/json"});
    if(res.statusCode==200){responseBody=json.decode(res.body);print(responseBody);}
    else{print("Booooom");}
    return responseBody;

  }



  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(

            brightness: Brightness.dark,

          title: Text("HISTORY",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

        backgroundColor: Colors.blueGrey[900],

          bottom: TabBar(
            tabs: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('TextBooks'),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Pages'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
                child: FutureBuilder(
                    future: this.getMethod1(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      List snap=snapshot.data;
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError){
                        //getMethod1();
                        //return Center(child: Text('Error fetching data'));
                        return Center(child: CircularProgressIndicator());
                      }
                      if(!(snapshot.hasData)){getMethod1();return Center(child: Text('No orders yet'));}
                      return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context,index){
                            return ExpansionCard(
                              title: Container(
                                  child:Column(
                                    children: <Widget>[
                                      Text(
                                        '${snap[index]['NAME']}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),),
                                      Text(
                                        "${snap[index]['SUBJECT']}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],)
                              ),
                              children: <Widget>[
                                Container(
                                  //margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: Text("copies:${snap[index]['COPIES']}\namount:${snap[index]['AMOUNT']}",
                                    style: TextStyle(fontSize: 10, color: Colors.white,
                                    ),),),
                              ],
                            );

                          });
                    }
                )
            ),
            Container(
              child: FutureBuilder(
                  future:this.getMethod2(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    List snap=snapshot.data;
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(!(snapshot.hasData)){return Center(child: Text('No orders yet'));}



                    return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (context,index){
                          return ExpansionCard(
                            title: Container(
                                child:Column(
                                  children: <Widget>[
                                    Text(
                                      '${snap[index]['NAME']}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),),
                                    Text(
                                      "${snap[index]['SUBJECT']}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],)
                            ),
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.symmetric(horizontal: 7),
                                child: Text("pages:${snap[index]['PAGES']}\ncopies:${snap[index]['COPIES']}amount:${snap[index]['AMOUNT']}",
                                  style: TextStyle(fontSize: 10, color: Colors.white,
                                  ),),),
                            ],
                          );

                        });
                  }
              ),)
          ],
        ),
      ),
    );
  }
}