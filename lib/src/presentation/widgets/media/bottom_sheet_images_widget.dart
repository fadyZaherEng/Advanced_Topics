// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/need_payment/need_payment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetImagesWidget extends StatefulWidget {
  final int min;
  final int max;

  const BottomSheetImagesWidget({
    super.key,
    required this.min,
    required this.max,
  });

  @override
  State<BottomSheetImagesWidget> createState() =>
      _BottomSheetImagesWidgetState();
}

class _BottomSheetImagesWidgetState extends State<BottomSheetImagesWidget> {
  NeedPaymentBloc get _bloc => BlocProvider.of<NeedPaymentBloc>(context);
  final List<XFile> _images = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NeedPaymentBloc, NeedPaymentState>(
      listener: (context, state) {
        if (state is OnNeedPaymentAddGalleryState) {
          _images.clear();
          //  _images.addAll(state.images);
        }
      },
      builder: (context, state) {
        if (_images.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "images",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorSchemes.black,
                    letterSpacing: -0.24,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 95,
                          width: 95,
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Container(
                                  width: 90,
                                  height: 85,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorSchemes.white,
                                  ),
                                  child: Image.file(
                                    File(_images[index].path),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                child: Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: InkWell(
                                    onTap: () {
                                      _bloc.add(
                                          OnNeedPaymentDeleteMediaEvent(index));
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: ColorSchemes.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorSchemes.gray
                                                .withOpacity(0.3),
                                            blurRadius: 25,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: SvgPicture.asset(
                                        ImagePaths.close,
                                        color: ColorSchemes.black,
                                        fit: BoxFit.scaleDown,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index == _images.length - 1)
                        const SizedBox(
                          width: 12,
                        ),
                      if (index == _images.length - 1)
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_images.length <= widget.max) {
                                _bloc.add(OnNeedPaymentAddMediaEvent());
                              } else {
                                _showDialog(context);
                              }
                            },
                            child: Container(
                              width: 90,
                              height: 85,
                              margin: const EdgeInsets.only(top: 10),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorSchemes.white,
                                border: Border.all(
                                  color: ColorSchemes.primary,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorSchemes.primary,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    ImagePaths.add,
                                    color: ColorSchemes.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemCount: _images.length,
              ),
            ),
            if (_images.isNotEmpty)
              const SizedBox(
                height: 10,
              ),
            Container(
              height: 1,
              color: ColorSchemes.border,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showMessageDialogWidget(
        context: context,
        text: "You can't add more images",
        icon: "ImagePaths.logo",
        buttonText: "Ok",
        onTap: () {
          Navigator.pop(context);
        });
  }
}
