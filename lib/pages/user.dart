import 'package:final_project/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:final_project/pages/signupPage.dart';
import 'package:final_project/controller/databaseHelper.dart';

class Users extends StatefulWidget {
  UsersState createState() => UsersState();
}

class UsersState extends State<Users> {
  List<User>? userLists;
  DatabaseHelper dbconn = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loadlist(),
          builder: (context, snapshot) {
            return userLists!.length > 0 ? viewlist() : Text('No Users yet');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignUp(false)));
        },
      ),
    );
  }

  Future? loadlist()  {
    final fdb =  dbconn.initDB();

    fdb.then((db) {
      Future<List<User>> flist = dbconn.getUser();
      flist.then((list) {
        setState(() {
          userLists = list;
        });
      });
    });
  }

  Widget viewlist() {
    return ListView.builder(
      itemCount: userLists == null ? 0 : userLists!.length,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: (){},
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(userLists![index].userName.toString()),
              subtitle: Text(userLists![index].userPassword.toString()),
            ),
          ),
        );
      },
    );
  }
}
