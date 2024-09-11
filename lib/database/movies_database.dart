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
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query = '''
        CREATE TABLE tblgenre(
          idgenre CHAR(1) primary key,
          dscGenre VARCHAR(50)
        );
        CREATE TABLE tblmovies(
          idMovie INTEGER PRIMARY KEY,
          nameMovie VARCHAR(100),
          overview TEXT,
          idgenre char(1),
          imagen VARCHAR(150),
          release CHAR(10),
          CONSTRAINT fk_gen FOREIGN KEY(idgenre) REFERENCES tblgenre(idgenre)
        );''';
        db.execute(query);
      },
    );
  }

  Future<int> INSERT(String table, Map<String, dynamic> row) async {
    var con = await database;
    con.insert(table, row);
  }
  Future<int> UPDATE() async {}
  Future<int> DELETE() async {}
  Future<List<MoviesDAO>> SELECT() async {}

}