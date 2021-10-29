
import 'package:flutter/material.dart';
import 'signupPage.dart';
import 'homePage.dart';
import 'profilePage.dart';
import 'package:final_project/controller/databaseHelper.dart';
import 'package:final_project/models/userModel.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  DatabaseHelper dbconn = new DatabaseHelper();

  final keyform = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  List<User>? userlist;
  bool? showDialogVar = false;

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      child: Image.asset('images/logo.png'),
      radius: 48,
      backgroundColor: Colors.white,
    );

    final appName = Center(
      child: Text(
        'R  e  n  t  a  l',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final userNameField = TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        labelText: 'User Name',
        labelStyle: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.brown,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'Please Enter User Name';
        else
          return null;
      },
      controller: _usernameController,
    );

    final passwordFiled = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.brown,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'Please Enter User Name';
        else
          return null;
      },
      controller: _passwordController,
    );

    final loginbutton = GestureDetector(
      child: Container(
        height: 40,
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Colors.brown[700],
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      onTap: () {
        if (keyform.currentState!.validate()) {
          keyform.currentState!.save();

          final fdb = dbconn.initDB();
          fdb.then((db) async {
            userlist = await dbconn.getLogin(
                _usernameController.text, _passwordController.text);
            if (userlist!.isNotEmpty && userlist != null)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(signinUser: userlist)));
            else {
              showdialogFunction();
            }
          });
        }
      },
    );

    final forget = Container(
      alignment: Alignment(1, 0),
      child: InkWell(
        child: Text(
          'forget password',
          style:
              TextStyle(color: Colors.brown[900], fontWeight: FontWeight.bold),
        ),
      ),
    );

    final createNewAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New In App',
          style: TextStyle(
            color: Colors.brown[900],
          ),
        ),
        InkWell(
          child: Text(
            ' Create New Account',
            style: TextStyle(
              color: Colors.brown[900],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUp(true)));
          },
        ),
      ],
    );

    return Scaffold(
      body: Form(
        key: keyform,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.brown[100],
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(30, 130, 30, 0),
              shrinkWrap: true,
              children: <Widget>[
                logo,
                SizedBox(height: 10),
                appName,
                SizedBox(height: 30),
                userNameField,
                SizedBox(height: 10),
                passwordFiled,
                SizedBox(height: 10),
                forget,
                SizedBox(height: 20),
                loginbutton,
                SizedBox(height: 20),
                createNewAccount,
                
              ],
            ),
          ),
        ),
       
      ),
    );
  }

  Future showdialogFunction()async{
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('User Not Found'),
          content: Text('User Name or Password is Not Found'),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
          ],
        );
      }
    );
  }

}
