import 'package:burger_order/services/submisson_service.dart';
import 'package:burger_order/widgets/question_widget.dart';
import 'package:flutter/material.dart';

import '../data/sample_questions.dart';

class BurgerOrderScreen extends StatefulWidget {
  const BurgerOrderScreen({super.key});

  @override
  State<BurgerOrderScreen> createState() => _BurgerOrderScreenState();
}

class _BurgerOrderScreenState extends State<BurgerOrderScreen> {
  final Map<String, dynamic> answers = {};
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void updateAnswer(String questionId, dynamic value) {
    setState(() {
      answers[questionId] = value;
    });
  }

  void submit() async {
    bool allValid =
        questions.every((q) => !q.isRequired || answers.containsKey(q.id));
    if (!allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك جاوب على كل الأسئلة المطلوبة.')),
      );
      return;
    }

    // تنفيذ ارسال البيانات هنا
    await SubmissionService.submitAnswers(answers);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تم الإرسال!'),
        content: const Text('تم تسجيل طلبك بنجاح.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void goToNextPage() {
    if (answers.containsKey(questions[_currentPage].id) &&
        answers[questions[_currentPage].id] != "") {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك جاوب على السؤال قبل المتابعة.')),
      );
    }
  }

  // دالة للانتقال إلى السؤال السابق
  void goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اطلب أكلك')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: questions.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return QuestionWidget(
                    question: question,
                    currentAnswer: answers[question.id],
                    onChanged: (val) => updateAnswer(question.id, val),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: goToPreviousPage,
                    child: const Text('رجوع'),
                  ),
                if (_currentPage == questions.length - 1)
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text('إرسال'),
                  )
                else
                  ElevatedButton(
                    onPressed: goToNextPage,
                    child: const Text('التالي'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
