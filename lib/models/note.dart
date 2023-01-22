import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveType(typeId: 0)
  late String id;

  @HiveType(typeId: 1)
  late String title;

  @HiveType(typeId: 2)
  late String text;

  @HiveType(typeId: 3)
  late String dateCreated;

  @HiveType(typeId: 4)
  late String dateModified;

  @HiveType(typeId: 5)
  late int modCount;

  Note();

  Note.createNote({
    required this.id,
    required this.title,
    required this.text,
    required this.dateCreated,
    required this.dateModified,
    required this.modCount,
  });

}
