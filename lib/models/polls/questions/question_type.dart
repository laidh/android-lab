enum QuestionType { SHORT_TEXT, LONG_TEXT, MULTIPLE, SINGLE }

extension QuestionTypeQuestion on QuestionType {
  String valueUkrainian() {
    switch (this) {
      case QuestionType.SHORT_TEXT:
        return 'Коротка відповідь';
      case QuestionType.LONG_TEXT:
        return 'Довга відповдіь';
      case QuestionType.MULTIPLE:
        return 'Декілька варіантів відповідей';
      case QuestionType.SINGLE:
        return 'Один з варіантів відповідей';
    }
  }
}
