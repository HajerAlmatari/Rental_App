
import 'package:flutter/material.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/real_estate_model.dart';

class SearchPage extends StatefulWidget {
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  DatabaseHelper dbconn = DatabaseHelper();
  List<Real_Estate>? realEstateList;

  final cities = ['Sanaa', 'Aden', 'Hodaida', 'Taiz'];
  final types = ['Appartment', 'House', 'Duplex Appartment'];
  final columns = ['type', 'city'];
  String? columnDropdownValue = 'type';
  String? cityDropdownValue = 'Sanaa';
  String? typeDropdownValue = 'Appartment';
  String? finalValue= 'Appartment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown[900]),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton(
                    value: columnDropdownValue,
                    items: columns.map(
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
                          columnDropdownValue = newValue;
                        },
                      );
                    },
                  ),
                  if (columnDropdownValue == 'city')
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
                  if (columnDropdownValue == 'type')
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
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.brown,
                    ),
                    onPressed: () {
                      setState(() {
                        finalValue = columnDropdownValue == 'type'
                          ? typeDropdownValue
                          : cityDropdownValue;

                        
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: loadSpecificList(columnDropdownValue.toString(), finalValue.toString()),
                builder: (context, snapshot) {
                  return realEstateList!.length > 0
                      ? viewRealEstate()
                      : Center(child: Text('No Real Estate Yet'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future loadSpecificList(String? column, String? value) async{
    final fdb = dbconn.initDB();
    fdb.then((value) {
      Future<List<Real_Estate>> flst = column == 'city'
          ? dbconn.getRealEstateofCity(value)
          : dbconn.getRealEstateofType(value);
      flst.then((list) {
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
                          onTap: () {}),
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
