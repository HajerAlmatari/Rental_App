import 'package:final_project/pages/addRealEstate.dart';
import 'package:final_project/pages/signupPage.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:final_project/models/userModel.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/real_estate_model.dart';

class ProfilePage extends StatefulWidget {
  final List<User>? user;
  ProfilePage(this.user);
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<Real_Estate>? realEstateList;
  DatabaseHelper dbconn = DatabaseHelper();
  User? editedUser;
  int selectedBottomNavigaionBarIndex = 1;
  @override
  void initState() {
    setState(() {
      editedUser = widget.user![0];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[50],

      /////////////////////////////////////////////////
      ///
      ///

      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width - 140,
            decoration: BoxDecoration(
              color: Colors.brown[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 120, 20, 0),
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
           
            width: 120,
            height: 120,
            margin: EdgeInsets.fromLTRB(100, 60, 100, 0),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
               color: Colors.brown[900],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/logo.png',),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(250, 120, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.brown[900],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUp(false, editedUser)));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 120, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.brown[900],
              ),
              onPressed: () {
                Navigator.popUntil(
                          context,
                          ModalRoute.withName(Navigator.defaultRouteName),
                        );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.fromLTRB(20, 185, 20, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    editedUser!.userName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      editedUser!.userAddressDescribtion.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Text(
                    editedUser!.userEmail.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    editedUser!.userPhoneNumber.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(35, 270, 30, 5),
            padding: EdgeInsets.all(0),
            child: FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return realEstateList!.length > 0
                    ? viewRealEstate()
                    : Center(child: Text('No Real Estate Yet'));
              },
            ),
          ),
        ],
      ),

      //////////////////////////////////////////////////////
      ///

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown[900],
        currentIndex: selectedBottomNavigaionBarIndex,
        onTap: (index) {
          setState(() {
            selectedBottomNavigaionBarIndex = index;
          });
          if (selectedBottomNavigaionBarIndex == 0)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(signinUser: widget.user)));
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
    );
  }

  Future loadList() async {
    final fdb = dbconn.initDB();
    fdb.then((value) {
      Future<List<Real_Estate>> flist = dbconn
          .getRealEstateOfUser(int.parse(widget.user![0].userId.toString()));
      flist.then((list) {
        setState(() {
          realEstateList = list;
        });
      });
    });
  }

  Widget viewRealEstate() {
    return ListView.builder(
      itemCount: realEstateList!.length,
      itemBuilder: (context, index) {
        return Container(
          child: Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 100,
                  decoration: BoxDecoration(
                    //boxShadow: shadowList,
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('images/building.png'),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 40),
                ),
                Container(
                  height: 120,
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
                          Container(width: 100,child: Text(realEstateList![index].type.toString()),),
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
                          Text(realEstateList![index].monthlyRent.toString()),
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
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddRealEstate(
                                  widget.user![0].userId,
                                  false,
                                  realEstateList![index])));
                        },
                      ),
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
}
