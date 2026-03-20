class Note {
  final String id;
  final String title;
  final List<dynamic> content;

  Note({required this.title, required this.content, String? id}) : id = id ?? DateTime.now().toIso8601String();

  Note copyWith({String? title, List<dynamic>? content}) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
