import 'package:flutter/material.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';
import 'package:volunteer/models/ui/center_list.dart';
import 'package:volunteer/screens/volunteering_center_screen.dart';

class VolunteeringsCentersListScreen extends StatelessWidget {

  final List<CenterList> _centers = [
    CenterList(
        '1',
        'МолоДвіж Центр (КУ "Львівський міський молодіжний центр")',
        'м. Львів, вул. Чайковського 31',
        'assets/images/images_for_centers/MOLODVIJ.png'),
    CenterList(
        '2',
        'YMCA Центр (КУ "Львівський міський молодіжний центр")',
        'м. Львів, вул. Чайковського 31',
        'assets/images/images_for_centers/YMCA.jpg'),
    CenterList(
        '3',
        'YMCA Центр (КУ "Львівський міський молодіжний центр")',
        'м. Львів, вул. Чайковського 31',
        'assets/images/images_for_centers/MOLODVIJ.png'),
    CenterList(
        '4',
        'YMCA Центр (КУ "Львівський міський молодіжний центр")',
        'м. Львів, вул. Чайковського 31',
        'assets/images/images_for_centers/YMCA.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "Молодіжні центри",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey[800],
                  size: 36,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ),
          ],
        ),
        body: new Column(
          children: [
          new Expanded(
            child: new ListView.builder(
                itemCount: _centers.length,
                itemBuilder: (BuildContext context, int index){
                  return new InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => VolunteeringCenterScreen()
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 243, 248),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(_centers.elementAt(index).pathToImage),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Text(
                              _centers.elementAt(index).title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                _centers.elementAt(index).adress,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ])
    );
  }
}
