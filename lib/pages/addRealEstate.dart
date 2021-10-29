import 'package:flutter/material.dart';
import 'package:final_project/models/real_estate_model.dart';
import 'package:final_project/controller/databaseHelper.dart';

class AddRealEstate extends StatefulWidget {
  int? userid;
  Real_Estate? rest;
  bool flag;
  AddRealEstate(this.userid, this.flag, [this.rest]);
  AddRealEstateState createState() => AddRealEstateState();
}

class AddRealEstateState extends State<AddRealEstate> {
  //////////////////////////////////////////////////

  var types = ['Appartment', 'House', 'Duplex Appartment'];
  var ages = ['New', '1-10 years', 'More than 10 years'];
  var cities = ['Sanaa', 'Aden', 'Hodaida', 'Taiz'];
  var sanaaStreets = ['Hada st.', 'Altahrer st.', 'Alasbahy st.', 'Alsten st.'];
  var hodaidaStreets = [
    'Shamsan st.',
    'Sanaa st.',
    'alhay Alseasy',
    'Alsten st.'
  ];
  var adenStreets = ['Almuala', 'Altuahi', 'Alshekh Othman'];
  var taizStreets = ['alshamasy'];

  /////////////////////////////////////////////////////////
  String? typesDropdownValue = 'Appartment';
  String? agesDropdownValue = 'New';
  String? citiesDropdownValue = 'Sanaa';
  String? streetsDropdownValue = 'Hada st.';
  String? withfurniture = 'Yes';
  final realEstateDescriptionController = TextEditingController();
  final addressDescriptionController = TextEditingController();
  final monthlyRentController = TextEditingController();
  final firstPaymentController = TextEditingController();
  final numberOfRoomsController = TextEditingController();
  final numberOfFloorsController = TextEditingController();
  int? realEstateID;

  ////////
  ///
  final keyform = GlobalKey<FormState>();
  DatabaseHelper dbconn = new DatabaseHelper();

  @override
  void initState() {
    if (widget.flag == false) {
      //اذا هو تحديث
      typesDropdownValue = widget.rest!.type.toString();
      agesDropdownValue = widget.rest!.age.toString();
      citiesDropdownValue = widget.rest!.city.toString();
      streetsDropdownValue = widget.rest!.street.toString();
      withfurniture = widget.rest!.furnisher.toString();
      // realEstateDescriptionController.text = widget.rest!.realEstateDesciption.toString();
      addressDescriptionController.text =
          widget.rest!.addressDescribtion.toString();
      monthlyRentController.text = widget.rest!.monthlyRent.toString();
      firstPaymentController.text = widget.rest!.firstPayment.toString();
      numberOfRoomsController.text = widget.rest!.numberOfRooms.toString();
      numberOfFloorsController.text = widget.rest!.numberOfFloors.toString();

      realEstateID = widget.rest!.realEstateId;
    }

    super.initState();
  }

  //////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        actions: [
          if (widget.flag == false)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final fdb = dbconn.initDB();
                fdb.then((db) async {
                  await dbconn.daleteRealEstate(widget.rest!.realEstateId);
                });
                Navigator.of(context).pop();
              },
            ),
        ],
        iconTheme: IconThemeData(color: Colors.brown[900]),
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(
            widget.flag ? 'Add Real Estate' : 'Update Real Estate',
            style: TextStyle(color: Colors.brown[900]),
          ),
        ),
      ),
      body: Form(
        key: keyform,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: <Widget>[
                ////////////////////////////////////////////////
                /// real Estate Descriptionn //
                TextFormField(
                  controller: realEstateDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Real Estate description',
                    labelStyle: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                ),
                ///////////////////////////////////////////

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Type',
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                        value: typesDropdownValue,
                        items: types.map(
                          (String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            typesDropdownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ///////////////////////////////////////////

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Age',
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 33,
                      ),
                      DropdownButton(
                        value: agesDropdownValue,
                        items: ages.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            agesDropdownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ///////////////////////////////////////////

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'City',
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 37,
                      ),
                      DropdownButton(
                        value: citiesDropdownValue,
                        items: cities.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            citiesDropdownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ///////////////////////////////////////////

                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Street',
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        value: streetsDropdownValue,
                        items: sanaaStreets.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            streetsDropdownValue = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ////////////////////////////////////////////////
                /// Address Descriptionn //
                TextFormField(
                  controller: addressDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Address description',
                    labelStyle: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                ),
                ////////////////////////////////////////////////
                /// Address Descriptionn //
                TextFormField(
                  controller: monthlyRentController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Monthly rent',
                    labelStyle: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                ),
                ////////////////////////////////////////////////
                /// Address Descriptionn //
                TextFormField(
                  controller: firstPaymentController,
                  decoration: InputDecoration(
                    labelText: 'First payment',
                    labelStyle: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                ),

                TextFormField(
                  controller: numberOfRoomsController,
                  decoration: InputDecoration(
                    labelText: 'Number of Rooms',
                    labelStyle: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                ),
                if (typesDropdownValue != 'Appartment')
                  TextFormField(
                    controller: numberOfFloorsController,
                    decoration: InputDecoration(
                      labelText: 'Number of floors',
                      labelStyle: TextStyle(
                        color: Colors.brown[900],
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'must be filled';
                      } else
                        return null;
                    },
                  ),
                SizedBox(
                  height: 25,
                ),

                Text(
                  'with furniture',
                  style: TextStyle(
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                ListTile(
                  title: const Text('Yes'),
                  leading: Radio<String>(
                    value: 'Yes',
                    groupValue: withfurniture,
                    onChanged: (String? value) {
                      setState(() {
                        withfurniture = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No'),
                  leading: Radio<String>(
                    value: 'No',
                    groupValue: withfurniture,
                    onChanged: (String? value) {
                      setState(
                        () {
                          withfurniture = value;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  child: Container(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.brown[900],
                      child: Center(
                        child: Text(
                          widget.flag ? 'Add' : 'Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (keyform.currentState!.validate()) {
                      keyform.currentState!.save();

                      if (widget.flag) {
                        final fdb = dbconn.initDB();
                        fdb.then((db) async {
                          await dbconn.insertRealEstate(Real_Estate(
                            realEstateDesciption:
                                realEstateDescriptionController.text.toString(),
                            type: typesDropdownValue.toString(),
                            age: agesDropdownValue.toString(),
                            city: citiesDropdownValue.toString(),
                            street: streetsDropdownValue.toString(),
                            addressDescribtion:
                                addressDescriptionController.text.toString(),
                            monthlyRent: monthlyRentController.text.toString(),
                            firstPayment:
                                firstPaymentController.text.toString(),
                            numberOfRooms:
                                numberOfRoomsController.text.toString(),
                            numberOfFloors: typesDropdownValue == "Appartment"
                                ? "1"
                                : numberOfRoomsController.text.toString(),
                            furnisher: withfurniture.toString(),
                            userId: widget.userid,
                          ));
                        });
                        fdb.then((value) => print(typesDropdownValue));
                        Navigator.of(context).pop();
                      } else if (widget.flag == false) {
                        final fdb = dbconn.initDB();
                        fdb.then((db) async {
                          await dbconn.updateRealEstate(Real_Estate(
                            realEstateId: widget.rest!.realEstateId,
                            realEstateDesciption:
                                realEstateDescriptionController.text,
                            type: typesDropdownValue.toString(),
                            age: agesDropdownValue.toString(),
                            city: citiesDropdownValue.toString(),
                            street: streetsDropdownValue.toString(),
                            addressDescribtion:
                                addressDescriptionController.text.toString(),
                            monthlyRent: monthlyRentController.text.toString(),
                            firstPayment:
                                firstPaymentController.text.toString(),
                            numberOfRooms:
                                numberOfRoomsController.text.toString(),
                            numberOfFloors: typesDropdownValue == "Appartment"
                                ? "1"
                                : numberOfFloorsController.text.toString(),
                            furnisher: withfurniture.toString(),
                            userId: widget.userid,
                          ));
                        });
                        Navigator.of(context).pop();
                        fdb.then((value) => print(widget.userid));
                      }

                      print(widget.flag);
                    }
                  },
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
