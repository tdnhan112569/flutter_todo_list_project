import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TodoInfo extends Equatable {
  const TodoInfo(this.content, this.isChecked, {this.id});
  final int? id;
  final String content;
  final bool isChecked;

  TodoInfo copyWith({String? content, bool? isChecked, int? id}) {
    return TodoInfo(content ?? this.content, isChecked ?? this.isChecked,
        id: id ?? this.id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, content, isChecked];

  @override
  String toString() {
    return "TodoInfo(id: $id, content: $content, isChecked: $isChecked)";
  }

  factory TodoInfo.fromMap(Map<String, dynamic> json) =>
      TodoInfo(json["content"] ?? "", json["isChecked"] ?? false,
          id: json["id"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "content": content,
        "isChecked": isChecked,
      };
}
