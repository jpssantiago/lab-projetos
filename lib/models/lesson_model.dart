enum LessonType {
  text,
}

class LessonModel {
  String? content;

  LessonModel({
    this.content,
  });

  static List<LessonModel> fromMapList(List<dynamic> list) {
    List<LessonModel> lessons = [];

    for (dynamic item in list) {
      lessons.add(LessonModel(content: item['content']));
    }

    return lessons;
  }
}
