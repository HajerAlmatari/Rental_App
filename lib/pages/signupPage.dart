import 'package:flutter/material.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/userModel.dart';
import 'package:sqflite/sqflite.dart';

class SignUp extends StatefulWidget {
  bool flag;
  User? editedUser;
  SignUp(this.flag, [this.editedUser]);

  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  DatabaseHelper dbconn = new DatabaseHelper();
  final keyform = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _EmailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _AddressController = TextEditingController();
  int? editedUserID;

  void initState() {
    if (widget.flag == false) {
      editedUserID = widget.editedUser!.userId;
      _usernameController.text = widget.editedUser!.userName.toString();
      _passwordController.text = "";
      _EmailController.text = widget.editedUser!.userEmail.toString();
      _phoneNumberController.text =
          widget.editedUser!.userPhoneNumber.toString();
      _AddressController.text =
          widget.editedUser!.userAddressDescribtion.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        actions: [
          if (widget.flag == false)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final fdb = dbconn.initDB();
                fdb.then((db) async {
                  await dbconn.daleteUser(widget.editedUser!.userId);
                });
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
            ),
        ],
        iconTheme: IconThemeData(color: Colors.brown[900]),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.flag ? 'Sign Up' : 'Edit User',
            style: TextStyle(
                color: Colors.brown[900], fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
        key: keyform,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: ListView(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'User Name',
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
                  controller: _usernameController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  controller: _passwordController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                  controller: _EmailController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must be filled';
                    } else
                      return null;
                  },
                  controller: _phoneNumberController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Your Address',
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
                  controller: _AddressController,
                ),
                SizedBox(height: 40),
                Container(
                  height: 40,
                  child: GestureDetector(
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.brown[900],
                      shadowColor: Colors.brown,
                      child: Center(
                        child: Text(
                          widget.flag ? 'Sign Up' : 'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (keyform.currentState!.validate()) {
                        keyform.currentState!.save();
                        if (widget.flag == true) {
                          final fdb = dbconn.initDB();
                          fdb.then((db) async {
                            await dbconn.insertUser(User(
                              userName: _usernameController.text.toString(),
                              userEmail: _EmailController.text.toString(),
                              userPassword: _passwordController.text.toString(),
                              userAddressDescribtion:
                                  _AddressController.text.toString(),
                              userPhoneNumber:
                                  _phoneNumberController.text.toString(),
                            ));
                          });
                          Navigator.pop(context);
                        } else if (widget.flag == false) {
                          final fdb = dbconn.initDB();
                          fdb.then(
                            (db) async {
                              await dbconn.updateUser(
                                User(
                                  userId: editedUserID,
                                  userName: _usernameController.text.toString(),
                                  userEmail: _EmailController.text.toString(),
                                  userPassword:
                                      _passwordController.text.toString(),
                                  userAddressDescribtion:
                                      _AddressController.text.toString(),
                                  userPhoneNumber:
                                      _phoneNumberController.text.toString(),
                                ),
                              );
                            },
                          );

                          Navigator.of(context).pop();
                        }
                        // fdb.then((value) => print(_usernameController.text));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
