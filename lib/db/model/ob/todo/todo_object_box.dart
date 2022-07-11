import 'package:objectbox/objectbox.dart';

@Entity()
class TodoOB {
  // Annotate with @Id() if name isn't "id" (case insensitive).
  int id = 0;
  final String content;
  final bool isChecked;
  TodoOB({required this.content, required this.isChecked, required this.id});
}
