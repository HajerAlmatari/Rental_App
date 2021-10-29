import 'package:flutter/material.dart';
import 'package:final_project/models/real_estate_model.dart';
import 'package:final_project/controller/databaseHelper.dart';

class RealEstatePage extends StatefulWidget {
  final Real_Estate rest;
  RealEstatePage(this.rest);
  DatabaseHelper dbconn = DatabaseHelper();

  RealEstatePageState createState() => RealEstatePageState();
}

class RealEstatePageState extends State<RealEstatePage> {
  //////////////////////////////////////////////////

  DatabaseHelper dbconn = new DatabaseHelper();

  //////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.brown[900]),
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.all(0),
          child: Text(
            'Real Estate Description',
            style: TextStyle(color: Colors.brown[900], fontSize: 20),
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(20, 30, 15, 0),
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.realEstateDesciption.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Type',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 64,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.type.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.age.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'City',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.city.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Street',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 53,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.street.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Adress',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 44,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        widget.rest.addressDescribtion.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Monthly Rent',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        widget.rest.monthlyRent.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'First Payment',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        widget.rest.firstPayment.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Number of Rooms',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        widget.rest.numberOfRooms.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Number of floors',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        widget.rest.numberOfFloors.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'With furniture',
                      style: TextStyle(
                        color: Colors.brown[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        widget.rest.furnisher.toString(),
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
