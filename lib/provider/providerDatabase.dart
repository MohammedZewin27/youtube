import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ProviderData extends ChangeNotifier {
  static List<Map<String, dynamic>> allVideos = [];
  static List<MyVideo> videos = [];
  Database? database;
  static const String tableName = 'youtubeVideo';

  createDatabase() {
    openDatabase(
      'video.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        videoTitle TEXT,
        videoUrl TEXT,
        videoId TEXT,
        videoPublishDate TEXT,
        videoDuration TEXT,
        videoImage TEXT
      )''');
        print("Table created");
      },
      onOpen: (db) async {
        database = db;
        readDatabase(database);
        print(allVideos);
      },
    ).then((value) {
      database = value;
      notifyListeners();
    });
  }

  insertDatabase({required MyVideo myVideo}) async {
    await database?.transaction((txn) {
      return txn
          .rawInsert(
        '''INSERT INTO $tableName(
           videoTitle,
           videoUrl,
           videoId,
           videoPublishDate,
           videoDuration,
           videoImage
           ) VALUES(
           "${myVideo.title}",
           "${myVideo.thumbnailUrl}",
           "${myVideo.videoId}",
           "${myVideo.publishDate}",
           "${myVideo.duration}",
           "${myVideo.image}"
           )''',
      )
          .then((value) {
        print("$value inserted successfully");
        readDatabase(database);
      })
          .catchError((onError) {
        print('error insert =====');
      });
    });
  }

  readDatabase(database) {
    database?.rawQuery('SELECT * FROM $tableName').then((value) {
      allVideos = value;
      videos = allVideos.map((videoMap) => MyVideo(
        videoId: videoMap['id'].toString(),
        title: videoMap['videoTitle'],
        thumbnailUrl: videoMap['videoUrl'],
        duration: videoMap['videoDuration'],
        publishDate: videoMap['videoPublishDate'],
        image: videoMap['videoImage'],
      )).toList();
      print(allVideos);
      notifyListeners();
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
}

class MyVideo {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String publishDate;
  final String image;

  MyVideo({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.publishDate,
    required this.image,
  });

  factory MyVideo.fromJson(Map<String, dynamic> json) {
    return MyVideo(
      videoId: json['videoId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration'],
      publishDate: json['publishDate'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'publishDate': publishDate,
      'image': image,
    };
  }
}
