import 'package:flutter/material.dart';

import 'contribute.dart';
import 'settings.dart';
import 'history.dart';
import 'feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBar extends StatefulWidget {
  final String name;
  final String email;

  const MenuBar({Key key, this.name, this.email}) : super(key: key);
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://st.depositphotos.com/2815327/3510/v/600/depositphotos_35105363-stock-video-abstract-blue-background-with-vertical.jpg"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill ,
                ),
              ),
              accountName: Text(""),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.account_circle),
                backgroundColor: Colors.blueGrey,

              ),
            ),

            ListTile(
                leading: Icon(Icons.
                history),
                title: Text('History'),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => YourHistory(),
                ),);

                }
            ),
            ListTile(
                leading: Icon(Icons.control_point),
                title: Text('Contribute'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Contribute(),
                  ),);

                }
            ),
            ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeedBackSend(),
                  ),);
                }
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                ),);

                }
            ),
          ]
      ),
    );

  }
}



