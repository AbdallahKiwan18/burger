import 'package:burger_order/models/question_model.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionModel question;
  final dynamic currentAnswer;
  final ValueChanged<dynamic> onChanged;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.currentAnswer,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.singleChoice:
        return _buildSingleChoice();
      case QuestionType.multipleChoice:
        return _buildMultipleChoice();
      case QuestionType.textInput:
        return _buildTextInput();
      case QuestionType.imageChoice:
        return _buildImageChoice();
      default:
        return Container();
    }
  }

  Widget _buildSingleChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...question.options!.map((option) {
          return RadioListTile<String>(
            title: Text(option.label),
            value: option.label,
            groupValue: currentAnswer,
            onChanged: (val) => onChanged(val),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMultipleChoice() {
    // تأكد من أن currentAnswer هو قائمة حتى لو كانت فارغة
    final List<String> selectedAnswers = currentAnswer ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...question.options!.map((option) {
          return CheckboxListTile(
            title: Text(option.label),
            value: selectedAnswers.contains(option.label),
            onChanged: (bool? value) {
              List<String> updatedAnswers = List.from(selectedAnswers);
              if (value == true) {
                updatedAnswers.add(option.label);
              } else {
                updatedAnswers.remove(option.label);
              }
              onChanged(updatedAnswers);
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTextInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'أدخل إجابتك',
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => onChanged(val),
          controller: TextEditingController(text: currentAnswer),
        ),
      ],
    );
  }

  Widget _buildImageChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...question.options!.map((option) {
          return GestureDetector(
            onTap: () => onChanged(option.label),
            child: Column(
              children: [
                Image.network(option.imageUrl!, width: 100, height: 100),
                Text(option.label),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
