enum LessonType {
  text,
}

class LessonModel {
  String? content;
  String? code;

  LessonModel({
    this.content,
    this.code,
  });

  static List<LessonModel> fromMapList(List<dynamic> list) {
    List<LessonModel> lessons = [];

    for (dynamic item in list) {
      lessons.add(LessonModel(
        content: item['content'],
        code: item['code'],
      ));
    }

    return lessons;
  }
}
