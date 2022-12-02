import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "dart:io" as io;

class DatabaseHelper {
  static Database _db;
  // static const String NUMBER = 'number';
  static const String TABLE = 'all_chats';
  static const String DB_NAME = 'local.db';

  Future<Database> get db async {
    if (_db != null) {
      print("DATABASE ALREADY EXISTS");
      return _db;
    }
    print("CREATING NEW DATABASE");
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE (id INTEGER PRIMARY KEY,
      toId TEXT NOT NULL,
      toName TEXT NOT NULL,
      toEmail TEXT NOT NULL,
      toPublicKey TEXT NOT NULL,
      toProfilePic TEXT NOT NULL,
      fromId TEXT NOT NULL,
      fromName TEXT NOT NULL,
      fromEmail TEXT NOT NULL,
      fromPublicKey TEXT NOT NULL,
      fromProfilePic TEXT NOT NULL,
      message TEXT,
      sentAt TEXT NOT NULL,
      seen BIT NOT NULL,
      isStored BIT NOT NULL);
    ''');
  }

  Future insert(Map<String, dynamic> row) async {
    print("BEFORE DB");
    var dbClient = await db;
    print("AFTER DB");
    // var res = await db.rawInsert('''
    // INSERT INTO contacts (number) VALUES (?)
    // ''', [newContact.number]);

    // return res;
    var res = await dbClient.insert(TABLE, row);
    // return newContact;
  }

  Future getChats() async {
    var dbClient = await db;
    var res = await dbClient.query(TABLE, columns: [
      "toId",
      "toName",
      "toEmail",
      "toPublicKey",
      "toProfilePic",
      "fromId",
      "fromName",
      "fromEmail",
      "fromPublicKey",
      "fromProfilePic",
      "message",
      "sentAt",
      "seen",
      "isStored"
    ]);
    print("DATABASE VALUES");
    print(res.length);
    return res;
  }

  Future updateSeen(senderId, receiverId) async {
    var dbClient = await db;
    var res = await dbClient.rawUpdate('''
    UPDATE $TABLE SET seen=? WHERE fromId=? AND toId=?
    ''', [1, senderId, receiverId]);
    print("UPDATED SEEN IN LOCAL STORAGE");
    return res;
  }

  Future updateIsStored(senderId, receiverId) async {
    var dbClient = await db;
    var res = await dbClient.rawUpdate('''
    UPDATE $TABLE SET isStored=? WHERE fromId=? AND toId=?
    ''', [1, senderId, receiverId]);
    print("UPDATED SEEN IN LOCAL STORAGE");
    return res;
  }

  Future deleteSelectedUserChats(userId, selectedUserId) async {
    var dbClient = await db;
    var res = await dbClient.rawDelete(
        '''DELETE FROM $TABLE WHERE (fromId=? AND toId = ?) OR (fromId=? AND toId = ?)''',
        [userId, selectedUserId, selectedUserId, userId]);
    print("res here");
    print(res);
    print("chats deleted");
    print(res);
  }

  Future dropTable() async {
    var dbClient = await db;
    var res = await dbClient.rawDelete("DELETE FROM $TABLE");
    print("res here");
    print(res);
    print("DATABASE VALUES");
    print(res);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
