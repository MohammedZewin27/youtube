import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ProviderData extends ChangeNotifier {
  List<Map> allVideos = [];

  ///videoDownload.id;
//           videoDownload.url;
//           videoDownload.title;
//           videoDownload.publishDate;
//           videoDownload.author;
//           videoDownload.description;
//           videoDownload.duration;

  Database? database;
  static const String tableName = 'myVideo';

  createDatabase() {
    openDatabase(
      'video.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
         videoDownloadTitle TEXT,
         videoDownloadId TEXT,
        videoDownloadUrl TEXT,
        videoDownloadPublishDate TEXT,
        videoDownloadDescription TEXT,
        videoDownloadDuration TEXT,
        )''');



      ///  videoDownloadTitle,videoDownloadId,videoDownloadUrl,videoDownloadPublishDate,videoDownloadDescription,videoDownloadDuration

        print("table created ");
      },
      onOpen: (database) async {
        readDatabase(database);
        print(allVideos);
      },
    ).then((value) {
      database = value;
    });
    notifyListeners();
  }

  insertDatabase({required String title, required String massage}) async {
    await database?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO $tableName(title, text) VALUES("$title","$massage")')
          .then((value) {
        print("$value inserted successfully");
        readDatabase(database);
      }).catchError((onError) {
        print('error insert =====');
      });
    });
  }

  updateDatabase(
      {required String title, required String massage, required int id}) async {
    await database?.rawUpdate(
        'UPDATE $tableName SET title = ?, text = ? WHERE id = ?',
        [title, massage, '$id']).then((value) {
      print("$value update successfully");
      readDatabase(database);
    }).catchError((onError) {
      print('error update ===== $onError');
    });
  }

  deleteRowInDatabase({required int id}) async {
    await database
        ?.rawDelete('DELETE FROM $tableName WHERE id = $id')
        .then((value) {
      print("$value delete successfully");
      readDatabase(database);
    }).catchError((onError) {
      print('error delete ===== $onError');
    });
  }

  readDatabase(database) {
    database?.rawQuery('SELECT * FROM $tableName').then((value) {
      allVideos = value;
      print(allVideos);
      notifyListeners();
    });
  }
}
