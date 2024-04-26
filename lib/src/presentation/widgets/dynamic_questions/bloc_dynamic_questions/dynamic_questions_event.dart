import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/dynamic_question_validation_use_case.dart';

abstract class DynamicQuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SelectSingleSelectionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectSingleSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class SelectMultiSelectionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final int answerId;

  SelectMultiSelectionAnswerEvent({
    required this.questions,
    required this.question,
    required this.answerId,
  });
}

class DeleteQuestionAnswerEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionAnswerEvent({
    required this.questions,
    required this.question,
  });
}

class AddAnswerToQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final dynamic answer;

  AddAnswerToQuestionEvent({
    required this.questions,
    required this.question,
    required this.answer,
  });
}

class SelectQuestionImageEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;
  final String imagePath;

  SelectQuestionImageEvent({
    required this.questions,
    required this.question,
    required this.imagePath,
  });
}

class DeleteQuestionImageEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;
  final PageField question;

  DeleteQuestionImageEvent({
    required this.questions,
    required this.question,
  });
}

class OpenMediaBottomSheetEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  OpenMediaBottomSheetEvent({
    this.questions,
    this.question,
  });
}

class CameraPressedEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  CameraPressedEvent({
    this.questions,
    this.question,
  });
}

class GalleryPressedEvent extends DynamicQuestionsEvent {
  final List<PageField>? questions;
  final PageField? question;

  GalleryPressedEvent({
    this.questions,
    this.question,
  });
}

class AskForCameraPermissionEvent extends DynamicQuestionsEvent {
  final Function() onTab;
  final bool isGallery;

  AskForCameraPermissionEvent({
    required this.onTab,
    required this.isGallery,
  });
}

class CheckValidationForAllQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  CheckValidationForAllQuestionEvent({
    required this.questions,
  });
}

class OkButtonPressedEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  OkButtonPressedEvent({
    required this.questions,
  });
}

class ScrollToUnAnsweredMandatoryQuestionEvent extends DynamicQuestionsEvent {
  final List<PageField> questions;

  ScrollToUnAnsweredMandatoryQuestionEvent({
    required this.questions,
  });
}

class NavigateBackEvent extends DynamicQuestionsEvent {}

class PageField extends Equatable {
  final int id;
  final int typeId;
  final int eventOptionId;
  final int maxCount;
  final int minCount;
  final String code;
  final String label;
  final String description;
  final bool isRequired;
  final String value;
  final String answerId;
  final List<Choice> choices;
  final List<File> imagesList;
  final String errorMessage;
  final bool fileValid;
  final GlobalKey? key;
  final int? index;
  final bool notAnswered;
  final String expireDate;
  final bool isEditable;
  final bool isDeletable;
  final String canNotDeleteReason;
  final String canNotEditReason;
  final bool isFromServer;
  final bool isHasRelatedQuestion;
  final List<Validation> validations;
  final bool isValid;
  final String validationMessage;

  PageField({
    this.id = 0,
    this.typeId = 0,
    this.eventOptionId = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.code = "",
    this.label = "",
    this.description = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.choices = const [],
    this.validations = const [],
    this.imagesList = const [],
    this.errorMessage = "",
    this.fileValid = false,
    this.index = 0,
    this.key,
    this.notAnswered = false,
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
    this.isFromServer = false,
    this.isHasRelatedQuestion = false,
    this.isValid = true,
    this.validationMessage = "",
  });

  PageField copyWith({
    int? id,
    int? typeId,
    int? eventOptionId,
    int? maxCount,
    int? minCount,
    String? code,
    String? label,
    String? description,
    bool? isRequired,
    String? value,
    String? answerId,
    List<Choice>? choices,
    List<File>? imagesList,
    String? errorMessage,
    bool? fileValid,
    int? index,
    GlobalKey? key,
    bool? notAnswered,
    String? expireDate,
    bool? isEditable,
    bool? isDeletable,
    String? canNotDeleteReason,
    String? canNotEditReason,
    bool? isFromServer,
    bool? isHasRelatedQuestion,
    List<Validation>? validations,
    bool? isValid,
    String? validationMessage,
  }) {
    return PageField(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      maxCount: maxCount ?? this.maxCount,
      minCount: minCount ?? this.minCount,
      code: code ?? this.code,
      label: label ?? this.label,
      description: description ?? this.description,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      answerId: answerId ?? this.answerId,
      choices: choices ?? this.choices,
      imagesList: imagesList ?? this.imagesList,
      errorMessage: errorMessage ?? this.errorMessage,
      fileValid: fileValid ?? this.fileValid,
      index: index ?? this.index,
      key: key ?? this.key,
      notAnswered: notAnswered ?? this.notAnswered,
      expireDate: expireDate ?? this.expireDate,
      isEditable: notAnswered ?? this.isEditable,
      isDeletable: isDeletable ?? this.isDeletable,
      canNotDeleteReason: canNotDeleteReason ?? this.canNotDeleteReason,
      canNotEditReason: canNotEditReason ?? this.canNotEditReason,
      isFromServer: isFromServer ?? this.isFromServer,
      isHasRelatedQuestion: isHasRelatedQuestion ?? this.isHasRelatedQuestion,
      validations: validations ?? this.validations,
      isValid: isValid ?? this.isValid,
      validationMessage: validationMessage ?? this.validationMessage,
      eventOptionId: eventOptionId ?? this.eventOptionId,
      //write the rest of the fields
    );
  }

  @override
  List<Object?> get props => [
        id,
        typeId,
        eventOptionId,
        maxCount,
        minCount,
        code,
        label,
        description,
        isRequired,
        value,
        answerId,
        choices,
        imagesList,
        errorMessage,
        fileValid,
        index,
        key,
        notAnswered,
        expireDate,
        isEditable,
        isDeletable,
        canNotDeleteReason,
        isFromServer,
        canNotEditReason,
        validations,
        eventOptionId,
        isHasRelatedQuestion,
        isValid,
        validationMessage
      ];

  PageField deepClone() {
    return PageField(
      id: id,
      typeId: typeId,
      eventOptionId: eventOptionId,
      maxCount: maxCount,
      minCount: minCount,
      code: code,
      label: label,
      description: description,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
      choices: choices.map((choice) => choice.deepClone()).toList(),
      imagesList: imagesList.map((image) => File(image.path)).toList(),
      errorMessage: errorMessage,
      fileValid: fileValid,
      key: key,
      // Note: This will still reference the same GlobalKey
      index: index,
      notAnswered: notAnswered,
      expireDate: expireDate,
      isEditable: isEditable,
      isDeletable: isDeletable,
      canNotDeleteReason: canNotDeleteReason,
      canNotEditReason: canNotEditReason,
      isFromServer: isFromServer,
      validations: validations,
      isValid: isValid,
      validationMessage: validationMessage,
    );
  }

  @override
  String toString() {
    return 'PageField{id: $id, typeId: $typeId, eventOptionId: $eventOptionId, code: $code, label: $label, description: $description, isRequired: $isRequired, value: $value, answerId: $answerId, choices: $choices, imagesList: $imagesList, errorMessage: $errorMessage, fileValid: $fileValid, key: $key, index: $index, notAnswered: $notAnswered, expireDate: $expireDate, isEditable: $isEditable, isDeletable: $isDeletable, canNotDeleteReason: $canNotDeleteReason, canNotEditReason: $canNotEditReason, isFromServer: $isFromServer, validations: $validations isValid: $isValid}';
  }
}

class Choice {
  final bool isSelected;
  final int id;
  final String value;

  Choice({
    required this.isSelected,
    required this.id,
    required this.value,
  });

  Choice deepClone() {
    return Choice(
      id: id,
      isSelected: isSelected,
      value: value,
    );
  }

  Choice copyWith({
    bool? isSelected,
    int? id,
    String? value,
  }) {
    return Choice(
      isSelected: isSelected ?? this.isSelected,
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }
}
