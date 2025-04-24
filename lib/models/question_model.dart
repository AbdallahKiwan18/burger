enum QuestionType {
  singleChoice,
  multipleChoice,
  textInput,
  imageChoice,
}

class QuestionModel {
  final String id;
  final String question;
  final QuestionType type;
  final List<OptionModel>? options;
  final bool isRequired;

  QuestionModel({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.isRequired = true,
  });
}

class OptionModel {
  final String label;
  final String? imageUrl;

  OptionModel({required this.label, this.imageUrl});
}
