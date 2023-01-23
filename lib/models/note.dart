import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveType(typeId: 0)
  final String id;

  @HiveType(typeId: 1)
  final String title;

  @HiveType(typeId: 2)
  final String text;

  @HiveType(typeId: 3)
  final String dateCreated;

  @HiveType(typeId: 4)
  final String dateModified;

  @HiveType(typeId: 5)
  final int modCount;

  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.dateCreated,
    required this.dateModified,
    required this.modCount,
  });

}
