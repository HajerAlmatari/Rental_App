import 'searchPage.dart';

import 'package:final_project/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/real_estate_model.dart';
import 'user.dart';
import 'addRealEstate.dart';
import 'realEstatePage.dart';
import 'profilePage.dart';

class HomePage extends StatefulWidget {
  List<User>? signinUser;
  HomePage({this.signinUser});

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Real_Estate>? realEstateList;
  List<Real_Estate>? saved;
  DatabaseHelper dbconn = DatabaseHelper();
  int selectedBottomNavigaionBarIndex = 0;

  //////////////////////////////
  ///  SEARCH VARIABLE //////
  final cities = ['Sanaa', 'Aden', 'Hodaida', 'Taiz'];
  final types = ['Appartment', 'House', 'Duplex Appartment'];
  final columns = ['type', 'city'];

  String? cityDropdownValue = 'Sanaa';
  String? typeDropdownValue = 'Appartment';

  
  String? columnDropdownValue = 'city';


  ////////////////////////////

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Search Options',
                  style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropdownButton(
                      value: columnDropdownValue,
                      items: columns.map((String items){
                        return DropdownMenuItem(value: items,child: Text(items),);
                      }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          columnDropdownValue = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    
                    if(columnDropdownValue == 'city')
                    DropdownButton(
                      value: cityDropdownValue,
                      items: cities.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            cityDropdownValue = newValue;
                          },
                        );
                      },
                    ),
                    if(columnDropdownValue == 'type')
                    DropdownButton(
                      value: typeDropdownValue,
                      items: types.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            typeDropdownValue = newValue;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print(columnDropdownValue);
                        print(typeDropdownValue);
                        print(cityDropdownValue);
                        if(columnDropdownValue == 'city')
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchPage('city',cityDropdownValue),
                          ),
                        );
                        else if(columnDropdownValue == 'type')
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchPage('type',typeDropdownValue),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.brown[900], size: 17),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            'R E N T A L',
            style: TextStyle(color: Colors.black),
          )),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 10, 1),
                  decoration: BoxDecoration(
                      color: Colors.brown[900],
                      borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddRealEstate(
                              int.parse(
                                  widget.signinUser![0].userId.toString()),
                              true)));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  child: Text('Add'),
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.brown[200],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: FutureBuilder(
                future: loadList(),
                builder: (context, snapshot) {
                  return realEstateList!.length > 0
                      ? viewRealEstate()
                      : Center(child: Text('No Real Estate Yet'));
                },
              ),

              /*
            child: FutureBuilder(
              future: loadList(), //يعرف على اي داله يعتمد في التحديث
              builder: (context, snapshot) {
                //يعرض البيانات الموجوده في اللست
                return realEstateList!.length > 0
                    ? viewRealEstate()
                    : Text('No Real Estate Yet');
              },
            ),
            */
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.brown[900],
          currentIndex: selectedBottomNavigaionBarIndex,
          onTap: (index) {
            setState(() {
              selectedBottomNavigaionBarIndex = index;
            });
            if (selectedBottomNavigaionBarIndex == 1)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(widget.signinUser)));
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Future loadList() async {
    final fdb = dbconn.initDB();
    fdb.then((value) {
      Future<List<Real_Estate>> flist = dbconn.getRealEstate();
      flist.then((list) {
        setState(() {
          realEstateList = list;
        });
      });
    });
  }

  Widget viewRealEstate() {
    return ListView.builder(
      itemCount: realEstateList == null ? 0 : realEstateList!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  height: 140,
                  width: 120,
                  decoration: BoxDecoration(
                    //boxShadow: shadowList,
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('images/building.png'),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(85, 0, 0, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.bookmark_outline,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  width: 150,
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.brown[200]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.category),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 100,
                            child: Text(realEstateList![index].type.toString()),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_pin),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 100,
                            child: Text(realEstateList![index].city.toString()),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.money),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                                realEstateList![index].monthlyRent.toString()),
                          ),
                        ],
                      ),
                      GestureDetector(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            decoration: BoxDecoration(
                                color: Colors.brown[900],
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
                            child: Text(
                              'view',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RealEstatePage(realEstateList![index])));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget realEstate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Expanded(
        child: Row(
          children: <Widget>[
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                //boxShadow: shadowList,
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 40),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        /////
                        /// Add To Saved List
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 130,
              width: 150,
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.brown[200]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.category),
                      SizedBox(
                        width: 10,
                      ),
                      Text('REST Type'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_pin),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        child: Text('REST Location'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.money),
                      SizedBox(
                        width: 10,
                      ),
                      Text('REST Price'),
                    ],
                  ),
                  GestureDetector(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                        decoration: BoxDecoration(
                            color: Colors.brown[900],
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: Text(
                          'view',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => RealEstatePage(realEstateList![indes])));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
