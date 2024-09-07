import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static const NAMEDB = 'MOVIESDB';
  static const VERSIONDB = 1;
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    return _database = await initDatabase();
  }

  Future<Database> initDatabase() async{
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path,NAMEDB);
  }

}