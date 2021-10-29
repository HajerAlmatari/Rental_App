import 'package:flutter/material.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/real_estate_model.dart';
import 'realEstatePage.dart';

class SearchPage extends StatefulWidget {
  String? value;
  String? columnType;
  SearchPage(this.columnType, this.value);
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  DatabaseHelper dbconn = DatabaseHelper();
  List<Real_Estate>? realEstateList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
          'Search Results',
          style: TextStyle(
            fontSize: 20,
            color: Colors.brown[900],
          ),
        ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown[900]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: FutureBuilder(
              future: widget.columnType == 'city'
                  ? loadListOfCity(widget.value)
                  : loadListOfType(widget.value),
              builder: (context, snapshot) {
                return realEstateList!.length > 0
                    ? viewRealEstate()
                    : Center(child: Text('No Real Estate Yet'));
              },
            ),
          ),
        ),
      ),
    );
  }

  Future loadListOfCity(String? city) async {
    final fdb = dbconn.initDB();
    fdb.then((value) {
      Future<List<Real_Estate>> flist = dbconn.getRealEstateofCity(city);
      flist.then((list) {
        setState(() {
          realEstateList = list;
        });
      });
    });
  }

  Future loadListOfType(String? type) async {
    final fdb = dbconn.initDB();
    fdb.then((value) {
      Future<List<Real_Estate>> flist = dbconn.getRealEstateofType(type);
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
}
