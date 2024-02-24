// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:io';
//
// import 'package:city_eye/generated/l10n.dart';
// import 'package:city_eye/src/config/theme/color_schemes.dart';
// import 'package:city_eye/src/core/resources/image_paths.dart';
// import 'package:city_eye/src/core/utils/permission_service_handler.dart';
// import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
// import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
// import 'package:city_eye/src/domain/entities/home/city_eye/extra_filed_events.dart';
// import 'package:city_eye/src/presentation/screens/city_eye_home/utils/question_type.dart';
// import 'package:city_eye/src/presentation/screens/city_eye_home/widgets/custom_button_option_widget.dart';
// import 'package:city_eye/src/presentation/widgets/custom_date_text_field_with_label_widget.dart';
// import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
// import 'package:city_eye/src/presentation/widgets/upload_Image_widget.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class BuildQuestionWidget extends StatefulWidget {
//   final ExtraFieldEvents extraFieldEvents;
//   final QuestionType questionType;
//   bool isComeFromHome;
//   final Function(ExtraFieldEvents, String?, File? file) onChange;
//
//   BuildQuestionWidget({
//     super.key,
//     required this.extraFieldEvents,
//     required this.questionType,
//     required this.onChange,
//     required this.isComeFromHome,
//   });
//
//   @override
//   State<BuildQuestionWidget> createState() => _BuildQuestionWidgetState();
// }
//
// class _BuildQuestionWidgetState extends State<BuildQuestionWidget> {
//   int optionSelected = -1;
//   Map<int, bool> choice = {};
//   TextEditingController textController = TextEditingController();
//   String multiMedia = "";
//   XFile? pickedImage;
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.extraFieldEvents.choice.length; i++) {
//       choice[i] = false;
//     }
//     optionSelected = -1;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     switch (widget.questionType) {
//       case QuestionType.date:
//         return _dateWidget(
//           extraField: widget.extraFieldEvents,
//           context: context,
//         );
//       case QuestionType.singleChoice:
//         return _singleChoiceWidget(
//           context: context,
//         );
//       case QuestionType.multipleChoice:
//         return _multipleChoiceWidget(
//           context: context,
//         );
//       case QuestionType.number:
//         return _numberWidget(
//           extraField: widget.extraFieldEvents,
//           context: context,
//         );
//       case QuestionType.image:
//         return _imageWidget(
//           context: context,
//         );
//       case QuestionType.text:
//         return _textWidget(
//           extraField: widget.extraFieldEvents,
//           context: context,
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }
//
//   Widget _dateWidget({
//     required ExtraFieldEvents extraField,
//     required BuildContext context,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         CustomDateTextFieldWithLabelWidget(
//           globalKey: GlobalKey(),
//           title: extraField.lable,
//           label: extraField.lable,
//           pickDate: (date) {
//             widget.onChange(
//                 extraField.copyWith(
//                   value: date,
//                 ),
//                 null,
//                 null);
//           },
//           deleteDate: () {
//             widget.onChange(
//                 extraField.copyWith(
//                   value: "",
//                 ),
//                 null,
//                 null);
//           },
//           errorMassage: extraField.isRequired &&
//                   extraField.value.isEmpty &&
//                   !widget.isComeFromHome
//               ? S.of(context).thisFieldIsRequired
//               : null,
//         ),
//       ],
//     );
//   }
//
//   Widget _multipleChoiceWidget({
//     required BuildContext context,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           widget.extraFieldEvents.lable,
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.copyWith(color: ColorSchemes.black),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         SizedBox(
//           height: 30,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, optionIndex) {
//               return CustomEventsButtonOptionWidget(
//                 onTap: () {
//                   choice[optionIndex] = !choice[optionIndex]!;
//                   String choiceList = "";
//                   for (var element in choice.entries) {
//                     if (element.value) {
//                       choiceList += widget
//                           .extraFieldEvents.choice[element.key].optionId
//                           .toString();
//                       choiceList += ",";
//                     }
//                   }
//                   widget.onChange(
//                       widget.extraFieldEvents.copyWith(
//                         value: choiceList,
//                       ),
//                       null,
//                       null);
//                 },
//                 buttonTitle:
//                     widget.extraFieldEvents.choice[optionIndex].optionValue,
//                 isSelected: choice[optionIndex] ?? false,
//               );
//             },
//             separatorBuilder: (context, index) => const SizedBox(
//               width: 10,
//             ),
//             itemCount: widget.extraFieldEvents.choice.length,
//           ),
//         ),
//         Visibility(
//           visible: widget.extraFieldEvents.isRequired &&
//               widget.extraFieldEvents.value.isEmpty &&
//               !widget.isComeFromHome,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 S.of(context).thisFieldIsRequired,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                       color: ColorSchemes.redError,
//                       letterSpacing: -.24,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _singleChoiceWidget({
//     required BuildContext context,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           widget.extraFieldEvents.lable,
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.copyWith(color: ColorSchemes.black),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         SizedBox(
//           height: 30,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, optionIndex) {
//               return CustomEventsButtonOptionWidget(
//                 onTap: () {
//                   optionSelected = optionIndex;
//                   widget.onChange(
//                       widget.extraFieldEvents.copyWith(
//                         value: widget
//                             .extraFieldEvents.choice[optionIndex].optionId
//                             .toString(),
//                       ),
//                       null,
//                       null);
//                 },
//                 buttonTitle:
//                     widget.extraFieldEvents.choice[optionIndex].optionValue,
//                 isSelected: optionSelected == optionIndex,
//               );
//             },
//             separatorBuilder: (context, index) => const SizedBox(
//               width: 10,
//             ),
//             itemCount: widget.extraFieldEvents.choice.length,
//           ),
//         ),
//         Visibility(
//           visible: widget.extraFieldEvents.isRequired &&
//               widget.extraFieldEvents.value.isEmpty &&
//               !widget.isComeFromHome,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 S.of(context).thisFieldIsRequired,
//                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                       color: ColorSchemes.redError,
//                       letterSpacing: -.24,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _numberWidget({
//     required ExtraFieldEvents extraField,
//     required BuildContext context,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           extraField.lable,
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.copyWith(color: ColorSchemes.black),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         CustomTextFieldWidget(
//           controller: textController,
//           labelTitle: extraField.description,
//           textInputType: TextInputType.number,
//           onChange: (value) {
//             widget.onChange(
//                 extraField.copyWith(
//                   value: value,
//                 ),
//                 null,
//                 null);
//           },
//           errorMessage: extraField.isRequired &&
//                   extraField.value.isEmpty &&
//                   !widget.isComeFromHome
//               ? S.of(context).thisFieldIsRequired
//               : null,
//         ),
//       ],
//     );
//   }
//
//   Widget _textWidget({
//     required ExtraFieldEvents extraField,
//     required BuildContext context,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           extraField.lable,
//           style: Theme.of(context)
//               .textTheme
//               .bodyMedium
//               ?.copyWith(color: ColorSchemes.black),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         CustomTextFieldWidget(
//           controller: textController,
//           labelTitle: extraField.description,
//           onChange: (value) {
//             widget.onChange(
//                 extraField.copyWith(
//                   value: value,
//                 ),
//                 null,
//                 null);
//           },
//           errorMessage: extraField.isRequired &&
//                   extraField.value.isEmpty &&
//                   !widget.isComeFromHome
//               ? S.of(context).thisFieldIsRequired
//               : null,
//           textInputType: TextInputType.text,
//         ),
//       ],
//     );
//   }
//
//   Widget _imageWidget({
//     required BuildContext context,
//   }) {
//     return UploadImageWidget(
//       deleteFileAction: (String filePath) {
//         widget.onChange(
//           widget.extraFieldEvents.copyWith(
//             value: "",
//           ),
//           null,
//           null,
//         );
//         pickedImage = null;
//       },
//       label: widget.extraFieldEvents.lable,
//       uploadImage: () {
//         _showBottomSheetMedia(context);
//       },
//       globalKey: GlobalKey(),
//       isMandatory: widget.extraFieldEvents.isRequired,
//       filePath: pickedImage != null ? pickedImage!.path : "",
//       fileErrorMassage: widget.extraFieldEvents.value.isEmpty &&
//               widget.extraFieldEvents.isRequired &&
//               !widget.isComeFromHome
//           ? S.of(context).thisFieldIsRequired
//           : null,
//     );
//   }
//
//   void _showBottomSheetMedia(BuildContext context) async {
//     showBottomSheetUploadMedia(
//       context: context,
//       onTapCamera: () async {
//         if (await PermissionServiceHandler().handleServicePermission(
//           setting: PermissionServiceHandler.getCameraPermission(),
//         )) {
//           Navigator.pop(context);
//           _pickImage(context);
//         } else if (!await PermissionServiceHandler().handleServicePermission(
//           setting: PermissionServiceHandler.getCameraPermission(),
//         )) {
//           showActionDialogWidget(
//               context: context,
//               text: S.of(context).youShouldHaveCameraPermission,
//               icon: ImagePaths.cameraTwo,
//               primaryText: S.of(context).ok,
//               secondaryText: S.of(context).cancel,
//               primaryAction: () async {
//                 openAppSettings().then((value) => Navigator.pop(context));
//               },
//               secondaryAction: () {
//                 Navigator.of(context).pop();
//               });
//         }
//       },
//       onTapGallery: () async {
//         if (await PermissionServiceHandler().handleServicePermission(
//           setting: PermissionServiceHandler.getGalleryPermission(
//             true,
//             androidDeviceInfo: Platform.isAndroid
//                 ? await DeviceInfoPlugin().androidInfo
//                 : null,
//           ),
//         )) {
//           Navigator.pop(context);
//           _getImageFromGallery(context);
//         } else if (!await PermissionServiceHandler().handleServicePermission(
//             setting: PermissionServiceHandler.getGalleryPermission(
//           true,
//           androidDeviceInfo:
//               Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
//         ))) {
//           showActionDialogWidget(
//             context: context,
//             text: S.of(context).youShouldHaveStoragePermission,
//             icon: ImagePaths.gallery,
//             primaryText: S.of(context).ok,
//             secondaryText: S.of(context).cancel,
//             primaryAction: () async {
//               openAppSettings().then(
//                 (value) async {
//                   Navigator.pop(context);
//                 },
//               );
//             },
//             secondaryAction: () {
//               Navigator.of(context).pop();
//             },
//           );
//         }
//       },
//     );
//   }
//
//   void _pickImage(BuildContext context) async {
//     pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     if (pickedImage != null) {
//       multiMedia =
//           "${widget.extraFieldEvents.id}.${pickedImage!.path.split(".").last}";
//       widget.onChange(
//         widget.extraFieldEvents.copyWith(
//           value: " ",
//         ),
//         multiMedia,
//         File(pickedImage!.path),
//       );
//     }
//   }
//
//   void _getImageFromGallery(BuildContext context) async {
//     pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedImage != null) {
//       multiMedia =
//           "${widget.extraFieldEvents.id}.${pickedImage!.path.split(".").last}";
//       widget.onChange(
//         widget.extraFieldEvents.copyWith(
//           value: " ",
//         ),
//         multiMedia,
//         File(pickedImage!.path),
//       );
//     }
//   }
// }
