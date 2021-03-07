import 'package:mongo_dart/mongo_dart.dart';

Future<List<Map>> fetchData() async {
  var db;
  var coll;
  List<Map> notesData;
  const dbPass = "1qaz2wsx";
  const uri = "mongodb+srv://Chess:" +
      dbPass +
      "@cluster0.hutuy.mongodb.net/jot_db?retryWrites=true&w=majority";
  try {
    db = await Db.create(uri);
    await db.open();

    //fetch
    coll = db.collection("notes");
    notesData = await coll.find().toList();
  } catch (err) {
    print("Error on connecting to database: $err");
  }

  return notesData;
}

// implement deleteNote()
// implement addNote()
