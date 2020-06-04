import 'package:mongo_dart/mongo_dart.dart';

main() async {
  Db db = new Db("mongodb://192.168.0.103:27017/testing");
  await db.open();
  print("success ---------------------------------");
  // DbCollection coll = db.collection("mycollection");
  // await coll.insert({"name": "buddy3"});
  // var people = await coll.find().toList();
  // print(people);
  // await coll.remove(await coll.findOne(where.eq("name", "buddy")));
  // people = await coll.find().toList();
  // print(people);
  await db.close();
}
