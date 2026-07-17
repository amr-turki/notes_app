import 'package:hive_flutter/hive_flutter.dart';
part 'notes.g.dart';

@HiveType(typeId: 0)
class Notes extends HiveObject {
  Notes({
    required this.color,
    required this.content,
    required this.date,
    required this.title,
  });
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  int color;

  @HiveField(3)
  String date;
}
