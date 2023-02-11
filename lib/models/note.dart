class Note {
  final String id;
  final String title;
  final String text;
  final String dateCreated;
  final String dateModified;
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

class Selectable<T> {
  bool isSelected = false;
  T data;
  Selectable(this.data, this.isSelected);
}
