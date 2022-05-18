class LessonModel {
  static List<LessonModel> fromMapList(List<dynamic> list) {
    List<LessonModel> lessons = [];

    for (dynamic item in list) {
      lessons.add(LessonModel());
    }

    return lessons;
  }
}
