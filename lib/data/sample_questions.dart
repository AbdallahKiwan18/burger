import 'package:burger_order/models/question_model.dart';

final questions = [
  QuestionModel(
    id: 'q1',
    question: 'تحب نوع الأكل يكون إيه؟',
    type: QuestionType.singleChoice,
    options: [
      OptionModel(label: 'حادق'),
      OptionModel(label: 'مسكر'),
      OptionModel(label: 'سبايسي'),
    ],
  ),
  QuestionModel(
    id: 'q2',
    question: 'اختار المكونات اللي تحبها',
    type: QuestionType.multipleChoice,
    options: [
      OptionModel(label: 'جبنة'),
      OptionModel(label: 'لحمة'),
      OptionModel(label: 'خضار'),
    ],
  ),
  QuestionModel(
    id: 'q3',
    question: 'اسمك كامل؟',
    type: QuestionType.textInput,
  ),
  QuestionModel(
    id: 'q4',
    question: 'اختار شكل الساندويتش اللي يعجبك',
    type: QuestionType.imageChoice,
    options: [
      OptionModel(label: 'كلاسيك', imageUrl: 'https://fakeimg.pl/600x400'),
      OptionModel(label: 'حار', imageUrl: 'https://fakeimg.pl/600x400'),
    ],
  ),
];
