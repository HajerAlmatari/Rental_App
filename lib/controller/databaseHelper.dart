import 'dart:async';
import 'package:final_project/models/userModel.dart';
import 'package:final_project/models/real_estate_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? database;
  String realestateTableName = 'realestates';
  Future initDB() async {
    if (database != null) {
      return database;
    }

    String databasePath = await getDatabasesPath();

    database = await openDatabase(
      join(databasePath, 'RealEstate'),
      onCreate: (db, versionn) {
        return creatwTables(db);
      },
      version: 1,
    );

    return database;
  }

  void creatwTables(Database db) async {
  await db.execute('CREATE TABLE $realestateTableName (realEstateId INTEGER PRIMARY KEY AUTOINCREMENT,realEstateDesciption TEXT, type TEXT,age Text, city TEXT, street TEXT,addressDescribtion TEXT, monthlyRent TEXT, firstPayment TEXT, numberOfFloors TEXT, numberOfRooms TEXT, furnisher TEXT, userId INTEGER, FOREIGN KEY (userId) REFERENCES users (userId) ON DELETE CASCADE ON UPDATE CASCADE )');
  await db.execute(
        'CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT,userPassword TEXT ,userName TEXT UNIQUE,userAddressDescribtion TEXT, userEmail TEXT, userPhoneNumber TEXT,userImage TEXT)');

    await db.execute(
        'CREATE TABLE images (imgRealEstateId INTEGER , realEstateImage TEXT, FOREIGN KEY (imgRealEstateId) REFERENCES realEstateTableName (realEstateId) ON DELETE CASCADE ON UPDATE CASCADE) ');
  }

  Future<User?> insertUser(User user) async {
    final Database? db = await database;
    await db!.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUser() async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query('users');

    return List.generate(maps.length, (i) {
      return User(
        userId: maps[i]['userId'],
        userName: maps[i]['userName'],
        userPassword: maps[i]['userPassword'],
        userAddressDescribtion: maps[i]['userAddressDescribtion'],
        userEmail: maps[i]['userEmail'],
        userPhoneNumber: maps[i]['userPhoneN'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db!.update(
      'users',
      user.toMap(),
      where: "userId = ?",
      whereArgs: [user.userId],
    );
  }

  Future<void> daleteUser(int? id) async {
    final db = await database;
    await db!.delete(
      'users',
      where: "userId = ?",
      whereArgs: [id],
    );
  }

  Future<List<User>?> getLogin(String user, String password) async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query('users',where: 'userName = ? AND userPassword = ?',whereArgs: [user,password]);

    if (maps.isNotEmpty || maps!=null)
      return List.generate(maps.length, (i) {
        return User(
          userId: maps[i]['userId'],
          userName: maps[i]['userName'],
          userPassword: maps[i]['userPassword'],
          userAddressDescribtion: maps[i]['userAddressDescribtion'],
          userEmail: maps[i]['userEmail'],
          userPhoneNumber: maps[i]['userPhoneNumber'],
        );
      });
  }

 
  
  

  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////



  Future<Real_Estate?> insertRealEstate(Real_Estate rst) async {
    final Database? db = await database;
    await db!.insert(
      realestateTableName,
      rst.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Real_Estate>> getRealEstate() async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(realestateTableName);

    return List.generate(maps.length, (i) {
      return Real_Estate(
        realEstateId: maps[i]['realEstateId'],
        realEstateDesciption: maps[i]['realEstateDesciption'],
        type: maps[i]['type'],
        city: maps[i]['city'],
        street: maps[i]['street'],
        addressDescribtion: maps[i]['addressDescribtion'],
        monthlyRent: maps[i]['monthlyRent'],
        firstPayment: maps[i]['firstPayment'],
        numberOfRooms: maps[i]['numberOfRooms'],
        numberOfFloors: maps[i]['numberOfFloors'],
        furnisher: maps[i]['furnisher'],
        userId: maps[i]['userId'], 
        age: maps[i]['age'],
      );
    });
  }

  Future<List<Real_Estate>> getRealEstateofCity(String? city) async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(realestateTableName,where: 'city = ?',whereArgs: [city]);

    return List.generate(maps.length, (i) {
      return Real_Estate(
        realEstateId: maps[i]['realEstateId'],
        realEstateDesciption: maps[i]['realEstateDesciption'],
        type: maps[i]['type'],
        city: maps[i]['city'],
        street: maps[i]['street'],
        addressDescribtion: maps[i]['addressDescribtion'],
        monthlyRent: maps[i]['monthlyRent'],
        firstPayment: maps[i]['firstPayment'],
        numberOfRooms: maps[i]['numberOfRooms'],
        numberOfFloors: maps[i]['numberOfFloors'],
        furnisher: maps[i]['furnisher'],
        userId: maps[i]['userId'], 
        age: maps[i]['age'],
      );
    });
  }
  Future<List<Real_Estate>> getRealEstateofType(String? type) async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(realestateTableName,where: 'type = ?',whereArgs: [type]);

    return List.generate(maps.length, (i) {
      return Real_Estate(
        realEstateId: maps[i]['realEstateId'],
        realEstateDesciption: maps[i]['realEstateDesciption'],
        type: maps[i]['type'],
        city: maps[i]['city'],
        street: maps[i]['street'],
        addressDescribtion: maps[i]['addressDescribtion'],
        monthlyRent: maps[i]['monthlyRent'],
        firstPayment: maps[i]['firstPayment'],
        numberOfRooms: maps[i]['numberOfRooms'],
        numberOfFloors: maps[i]['numberOfFloors'],
        furnisher: maps[i]['furnisher'],
        userId: maps[i]['userId'], 
      );
    });
  }

  Future<List<Real_Estate>> getRealEstateOfUser(int userID) async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(realestateTableName,where: 'userId = ?',whereArgs: [userID]);

    return List.generate(maps.length, (i) {
      return Real_Estate(
        realEstateId: maps[i]['realEstateId'],
        realEstateDesciption: maps[i]['realEstateDesciption'],
        type: maps[i]['type'],
        city: maps[i]['city'],
        street: maps[i]['street'],
        addressDescribtion: maps[i]['addressDescribtion'],
        monthlyRent: maps[i]['monthlyRent'],
        firstPayment: maps[i]['firstPayment'],
        numberOfRooms: maps[i]['numberOfRooms'],
        numberOfFloors: maps[i]['numberOfFloors'],
        furnisher: maps[i]['furnisher'],
        userId: maps[i]['userId'], 
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateRealEstate(Real_Estate rst) async {
    final db = await database;
    await db!.update(
      realestateTableName,
      rst.toMap(),
      where: "realEstateId = ?",
      whereArgs: [rst.realEstateId],
    );
  }

  Future<void> daleteRealEstate(int? id) async {
    final db = await database;
    await db!.delete(
      realestateTableName,
      where: "realEstateId = ?",
      whereArgs: [id],
    );
  }
}
