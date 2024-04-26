import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_event.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_state.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/dynamic_question_validation_use_case.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/questions_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DynamicQuestionsBloc
    extends Bloc<DynamicQuestionsEvent, DynamicQuestionsState> {
  final DynamicQuestionValidationUseCase _dynamicQuestionValidationUseCase;

  DynamicQuestionsBloc(
    this._dynamicQuestionValidationUseCase,
  ) : super(DynamicQuestionsInitial()) {
    on<OpenMediaBottomSheetEvent>(_onOpenMediaBottomSheetEvent);
    on<AskForCameraPermissionEvent>(_onAskForCameraPermissionEvent);
    on<CameraPressedEvent>(_onCameraPressedEvent);
    on<GalleryPressedEvent>(_onGalleryPressedEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<SelectSingleSelectionAnswerEvent>(_onSelectSingleSelectionAnswerEvent);
    on<SelectMultiSelectionAnswerEvent>(_onSelectMultiSelectionAnswerEvent);
    on<DeleteQuestionAnswerEvent>(_onDeleteQuestionAnswerEvent);
    on<AddAnswerToQuestionEvent>(_onAddAnswerToQuestionEvent);
    on<SelectQuestionImageEvent>(_onSelectQuestionImageEvent);
    on<DeleteQuestionImageEvent>(_onDeleteQuestionImageEvent);
    on<CheckValidationForAllQuestionEvent>(
        _onCheckValidationForAllQuestionEvent);
    on<ScrollToUnAnsweredMandatoryQuestionEvent>(
        _onScrollToUnAnsweredMandatoryQuestionEvent);
    on<OkButtonPressedEvent>(_onOkButtonPressedEvent);
  }

  FutureOr<void> _onOpenMediaBottomSheetEvent(
      OpenMediaBottomSheetEvent event, Emitter<DynamicQuestionsState> emit) {
    emit(OpenMediaBottomSheetState(
      questions: event.questions,
      question: event.question,
    ));
  }

  FutureOr<void> _onAskForCameraPermissionEvent(
      AskForCameraPermissionEvent event, Emitter<DynamicQuestionsState> emit) {
    emit(AskForCameraPermissionState(
      onTab: event.onTab,
      isGallery: event.isGallery,
    ));
  }

  FutureOr<void> _onCameraPressedEvent(
      CameraPressedEvent event, Emitter<DynamicQuestionsState> emit) {
    emit(OpenCameraState(
      questions: event.questions,
      question: event.question,
    ));
  }

  FutureOr<void> _onGalleryPressedEvent(
      GalleryPressedEvent event, Emitter<DynamicQuestionsState> emit) {
    emit(OpenGalleryState(
      questions: event.questions,
      question: event.question,
    ));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<DynamicQuestionsState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onSelectSingleSelectionAnswerEvent(
      SelectSingleSelectionAnswerEvent event,
      Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: !event.questions[i].choices[j].isSelected,
            );
            if (event.questions[i].choices[j].isSelected == true) {
              event.questions[i] =
                  event.questions[i].copyWith(notAnswered: false);
            } else {
              event.questions[i] =
                  event.questions[i].copyWith(notAnswered: true);
            }
          } else {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: false,
            );
          }
        }
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onSelectMultiSelectionAnswerEvent(
      SelectMultiSelectionAnswerEvent event,
      Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: !event.questions[i].choices[j].isSelected,
            );
          }
        }
      }
    }

    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(notAnswered: true);
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].isSelected) {
            event.questions[i] =
                event.questions[i].copyWith(notAnswered: false);
          }
        }
        break;
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onDeleteQuestionAnswerEvent(
      DeleteQuestionAnswerEvent event, Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] =
            event.questions[i].copyWith(value: "", notAnswered: true);
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onAddAnswerToQuestionEvent(
      AddAnswerToQuestionEvent event, Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );
      }

      if (event.questions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: event.questions[i].validations,
          value: event.questions[i].value,
          questionCode: event.questions[i].code,
        );

        if (!validation["isValid"]) {
          event.questions[i] = event.questions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
        } else {
          event.questions[i] = event.questions[i].copyWith(
            isValid: true,
            validationMessage: "",
          );
        }
      } else {
        event.questions[i] = event.questions[i].copyWith(
          isValid: true,
        );
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onSelectQuestionImageEvent(
      SelectQuestionImageEvent event, Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
            value: event.imagePath, notAnswered: false, isFromServer: false);
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onDeleteQuestionImageEvent(
      DeleteQuestionImageEvent event, Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
          notAnswered: true,
          isFromServer: false,
        );
      }
    }
    emit(UpdateDynamicQuestionState(questions: event.questions));
  }

  FutureOr<void> _onCheckValidationForAllQuestionEvent(
      CheckValidationForAllQuestionEvent event,
      Emitter<DynamicQuestionsState> emit) {
    bool isAllQuestionAnswered = true;
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].code == QuestionsCode.singleChoice) {
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].isSelected) {
            event.questions[i] = event.questions[i]
                .copyWith(value: event.questions[i].choices[j].id.toString());
          }
        }
      } else if (event.questions[i].code == QuestionsCode.multiChoice) {
        event.questions[i] = event.questions[i].copyWith(value: "");
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].isSelected) {
            if (event.questions[i].value == "") {
              event.questions[i] = event.questions[i]
                  .copyWith(value: event.questions[i].choices[j].id.toString());
            } else {
              event.questions[i] = event.questions[i].copyWith(
                  value:
                      "${event.questions[i].value},${event.questions[i].choices[j].id.toString()}");
            }
          }
        }
      }
    }

    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].isRequired && event.questions[i].value.isEmpty ||
          event.questions[i].isRequired && event.questions[i].value == "") {
        event.questions[i] = event.questions[i].copyWith(notAnswered: true);
        if (event.questions[i].code != QuestionsCode.multiImage &&
            event.questions[i].code != QuestionsCode.searchableMulti &&
            event.questions[i].code != QuestionsCode.searchableSingle &&
            event.questions[i].code != QuestionsCode.file) {
          isAllQuestionAnswered = false;
        }
      }
    }

    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].value.isNotEmpty) {
        Map<String, dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: event.questions[i].validations,
          value: event.questions[i].value,
          questionCode: event.questions[i].code,
        );

        if (!validation["isValid"] &&
                event.questions[i].code != QuestionsCode.multiImage ||
            !validation["isValid"] &&
                event.questions[i].code != QuestionsCode.searchableMulti ||
            !validation["isValid"] &&
                event.questions[i].code != QuestionsCode.searchableSingle ||
            !validation["isValid"] &&
                event.questions[i].code != QuestionsCode.file) {
          event.questions[i] = event.questions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
          isAllQuestionAnswered = false;
        } else {
          event.questions[i] = event.questions[i].copyWith(
            isValid: true,
            validationMessage: "",
          );
        }
      } else {
        event.questions[i] = event.questions[i].copyWith(
          isValid: true,
        );
      }
    }

    if (isAllQuestionAnswered) {
      emit(AllQuestionAnsweredState(questions: event.questions));
    } else {
      emit(UpdateDynamicQuestionState(questions: event.questions));
      add(
        ScrollToUnAnsweredMandatoryQuestionEvent(questions: event.questions),
      );
    }
  }

  FutureOr<void> _onOkButtonPressedEvent(
      OkButtonPressedEvent event, Emitter<DynamicQuestionsState> emit) {
    add(CheckValidationForAllQuestionEvent(
      questions: event.questions,
    ));
  }

  FutureOr<void> _onScrollToUnAnsweredMandatoryQuestionEvent(
      ScrollToUnAnsweredMandatoryQuestionEvent event,
      Emitter<DynamicQuestionsState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].isRequired && event.questions[i].notAnswered) {
        emit(ScrollToUnAnsweredMandatoryQuestionState(
            key: event.questions[i].key ?? GlobalKey()));
        break;
      }
    }
  }
}
