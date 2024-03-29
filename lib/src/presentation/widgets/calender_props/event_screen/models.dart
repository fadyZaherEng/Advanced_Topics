import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class EventData extends Equatable {
  List<HomeEventItem> events;
  List<PageField> dynamicQuestions;

  EventData({required this.events, required this.dynamicQuestions});

  @override
  List<Object?> get props => [
        events,
        dynamicQuestions,
      ];
}

final class HomeEventItem extends Equatable {
  final int id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String openingDate;
  final String closedDate;
  final bool isPaid;
  final int maxCountJoin;
  final int memberCount;
  final int memberPrice;
  final String locationAddress;
  final String locationLatitude;
  final String locationLongitude;
  final int transactionId;
  final String calenderRef;
  final List<HomeEventOption> eventsOptions;
  final List<EventRules> eventsRules;
  final List<EventAttachments> eventsAttachments;
  final HomeEventOption selectAction;
  final bool showTotalMembers;
  final GlobalKey? key;

  const HomeEventItem({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.startDate = "",
    this.endDate = "",
    this.openingDate = "",
    this.closedDate = "",
    this.selectAction = const HomeEventOption(
      id: 0,
      name: "",
    ),
    this.isPaid = false,
    this.maxCountJoin = 0,
    this.memberCount = 0,
    this.memberPrice = 0,
    this.transactionId = 0,
    this.locationAddress = "",
    this.locationLatitude = "",
    this.locationLongitude = "",
    this.calenderRef = "",
    this.eventsOptions = const [],
    this.eventsRules = const [],
    this.eventsAttachments = const [],
    this.showTotalMembers = true,
    this.key,
  });

  HomeEventItem copyWith({
    int? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? openingDate,
    String? closedDate,
    bool? isPaid,
    int? memberCount,
    int? maxCountJoin,
    int? memberPrice,
    int? transactionId,
    String? locationAddress,
    String? locationLatitude,
    String? locationLongitude,
    String? calenderRef,
    List<HomeEventOption>? eventsOptions,
    List<EventRules>? eventsRules,
    List<EventAttachments>? eventsAttachments,
    HomeEventOption? selectAction,
    bool? showTotalMembers,
    GlobalKey? key,
  }) {
    return HomeEventItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      openingDate: openingDate ?? this.openingDate,
      closedDate: closedDate ?? this.closedDate,
      isPaid: isPaid ?? this.isPaid,
      transactionId: transactionId ?? this.transactionId,
      memberCount: memberCount ?? this.memberCount,
      maxCountJoin: maxCountJoin ?? this.maxCountJoin,
      memberPrice: memberPrice ?? this.memberPrice,
      locationAddress: locationAddress ?? this.locationAddress,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      calenderRef: calenderRef ?? this.calenderRef,
      eventsOptions: eventsOptions ?? this.eventsOptions,
      eventsRules: eventsRules ?? this.eventsRules,
      eventsAttachments: eventsAttachments ?? this.eventsAttachments,
      selectAction: selectAction ?? this.selectAction,
      showTotalMembers: showTotalMembers ?? this.showTotalMembers,
      key: key ?? this.key,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        openingDate,
        closedDate,
        isPaid,
        memberCount,
        memberPrice,
        locationAddress,
        locationLatitude,
        locationLongitude,
        calenderRef,
        eventsOptions,
        transactionId,
        eventsRules,
        eventsAttachments,
        showTotalMembers,
      ];
}

class EventRules {}

class HomeEventOption {
  final int id;
  final String name;
  final bool isSelectedByUser;
  final bool isCalendar;
  const HomeEventOption({
    this.id = 0,
    this.name = "",
    this.isSelectedByUser = false,
    this.isCalendar = true,
  });

  HomeEventOption copyWith({
    int? id,
    String? name,
    bool? isSelectedByUser,
    bool? isCalendar,
  }) {
    return HomeEventOption(
      id: id ?? this.id,
      name: name ?? this.name,
      isCalendar: isCalendar ?? this.isCalendar,
      isSelectedByUser: isSelectedByUser ?? this.isSelectedByUser,
    );
  }
}

class EventAttachments {}

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
  final String label;
  final bool isSelected;
  final String value;
  final int id;

  const Choice({
    required this.label,
    this.isSelected = false,
    this.value = '',
    this.id = 0,
  });

  Choice copyWith({
    String? label,
    bool? isSelected,
    String? value,
    int? id,
  }) {
    return Choice(
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'Choice{label: $label}';
  }

  Choice deepClone() {
    return Choice(
      label: label ?? this.label,
    );
  }
}

class Validation {}

final class SubmitEvent extends Equatable {
  final int transactionId;
  final int countCurrentJoin;
  final List<PageField> fields;

  const SubmitEvent({
    this.transactionId = 0,
    this.countCurrentJoin = 0,
    this.fields = const [],
  });

  @override
  List<Object> get props => [
        transactionId,
        countCurrentJoin,
        fields,
      ];

  @override
  String toString() {
    return 'SubmitEvent{transactionId: $transactionId, countCurrentJoin: $countCurrentJoin fields: $fields}';
  }
}

class Sort {
  final int id;
  final String name;

  const Sort({
    required this.id,
    required this.name,
  });
}
