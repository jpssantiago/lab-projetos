enum LessonType { text, quiz }

class LessonModel {
  String content;
  LessonType type;
  String? code;
  List<String>? options;
  String? correctOption;

  LessonModel({
    required this.content,
    required this.type,
    this.code,
    this.options,
    this.correctOption,
  });

  bool get hasCode => code != null;
  bool get isQuiz => type == LessonType.quiz;

  static LessonType getType(String str) {
    switch (str) {
      case 'quiz':
        return LessonType.quiz;
      case 'text':
      default:
        return LessonType.text;
    }
  }

  static List<LessonModel> fromMapList(List<dynamic> list) {
    List<LessonModel> lessons = [];

    for (dynamic item in list) {
      List<String>? options;

      if (item['options'] != null) {
        options = [];

        for (var item in item['options']) {
          options.add(item as String);
        }
      }

      lessons.add(LessonModel(
        content: item['content'],
        code: item['code'],
        type: getType(item['type']),
        options: options,
        correctOption: item['correct_option'],
      ));
    }

    return lessons;
  }
}
