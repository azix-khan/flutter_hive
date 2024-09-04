import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  //give hive unique field
  @HiveField(0)
  String title;

  // give hive unique field
  @HiveField(1)
  String description;

  /*
  -> after this run this command
  -> flutter packages pub run build_runner build 
  */

  NotesModel({
    required this.title,
    required this.description,
  });
}
