import 'package:equatable/equatable.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/questions_code.dart';

class DynamicQuestionValidationUseCase {
  Map<String, dynamic> call({
    required List<Validation> validation,
    required String value,
    required String questionCode,
  }) {
    return _isValid(validation, value, questionCode);
  }

  Map<String, dynamic> _isValid(
      List<Validation> validation, String value, String questionCode) {
    bool isAnswerValid = true;
    String validationMessage = "";
    try {
      for (int i = 0; i < validation.length; i++) {
        if (validation[i].validationRule.code == "=" &&
            questionCode != QuestionsCode.date) {
          if (int.parse(value) == int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == ">") {
          if (int.parse(value) > int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "<") {
          if (int.parse(value) < int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == ">=") {
          if (int.parse(value) >= int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "<=") {
          if (int.parse(value) <= int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "!=") {
          if (int.parse(value) != int.parse(validation[i].valueOne)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "REGX") {
          var regExp = RegExp(validation[i].valueOne);
          if (regExp.hasMatch(value)) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "After") {
          if (DateTime.parse(value)
              .isAfter(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "Before") {
          if (DateTime.parse(value)
              .isBefore(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "=") {
          if (DateTime.parse(value)
              .isAtSameMomentAs(DateTime.parse(validation[i].valueOne))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        } else if (validation[i].validationRule.code == "between") {
          if (DateTime.parse(value)
                  .isAfter(DateTime.parse(validation[i].valueOne)) &&
              DateTime.parse(value)
                  .isBefore(DateTime.parse(validation[i].valueTwo))) {
            isAnswerValid = true;
          } else {
            isAnswerValid = false;
            validationMessage = validation[i].validationMessage;
            break;
          }
        }
        if (!isAnswerValid) {
          break;
        }
      }
    } catch (e) {
      return {'isValid': true, 'validationMessage': ''};
    }

    return {
      'isValid': isAnswerValid,
      'validationMessage': validationMessage,
    };
  }
}

class Validation extends Equatable {
  final int id;
  final ValidationRule validationRule;
  final String valueOne;
  final String valueTwo;
  final String validationMessage;

  const Validation({
    this.id = 0,
    this.validationRule = const ValidationRule(),
    this.valueOne = "",
    this.valueTwo = "",
    this.validationMessage = "",
  });

  @override
  List<Object?> get props => [
        id,
        validationRule,
        valueOne,
        valueTwo,
        valueTwo,
        validationMessage,
      ];
}

class ValidationRule extends Equatable {
  final int id;
  final String code;

  const ValidationRule({
    this.id = 0,
    this.code = "",
  });

  @override
  List<Object?> get props => [
        id,
        code,
      ];
}
