import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {

  final String title;

  final Function pressDetails;
  final Function pressRead;

  const ReadingListCard({
    Key key,

    this.title,

    this.pressDetails,
    this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // drawer: MenuBar();
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            child: Container(
              height: 80,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: Colors.blue),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(

                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pressDetails,

                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("VIEW"),
                          //onTap: () {
                          //  Navigator.of(context).push(MaterialPageRoute(
                          //  builder: (context) =>   CustomTextBook(),
                          //  ),);
                          //  },
                        ),
                      ),



                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
