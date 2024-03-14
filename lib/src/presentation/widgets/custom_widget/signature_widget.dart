// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatefulWidget {
  final void Function(Uint8List? bytes) onTapSaveSignature;
  final void Function() onTapClearSignature;
  Uint8List? signatureImage;
  String signatureImageNetwork;
  bool isNetworkImage;

  SignatureWidget(
      {required this.onTapSaveSignature,
      required this.onTapClearSignature,
      required this.signatureImage,
      this.signatureImageNetwork = "",
      this.isNetworkImage = false,
      super.key});

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  late SignatureController _controller;

  Uint8List? signatureImage;
  String signatureImageNetwork = "";
  bool isNetworkImage = false;

  @override
  void initState() {
    super.initState();
    signatureImage = widget.signatureImage;
    signatureImageNetwork = widget.signatureImageNetwork;
    isNetworkImage = widget.isNetworkImage;

    _controller = SignatureController(
        penStrokeWidth: 2,
        exportBackgroundColor: ColorSchemes.white,
        penColor: ColorSchemes.black);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorSchemes.lightGray),
          ),
          child: isNetworkImage
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      signatureImageNetwork,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error,
                          stackTrace) =>
                          _buildPlaceHolderImage(),
                      loadingBuilder:
                          (BuildContext context,
                          Widget child,
                          ImageChunkEvent?
                          loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child:
                            CircularProgressIndicator(
                              color:
                              ColorSchemes.primary,
                              value: loadingProgress
                                  .expectedTotalBytes !=
                                  null
                                  ? loadingProgress
                                  .cumulativeBytesLoaded /
                                  loadingProgress
                                      .expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(
                  child: signatureImage != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.memory(signatureImage!,
                                  fit: BoxFit.fill)),
                        )
                      : Signature(
                          controller: _controller,
                          height: 200, // Set the height of the signature area
                          backgroundColor:
                              Colors.white, // Set the background color
                        ),
                ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomButtonWidget(
                onTap: () {
                  if (isNetworkImage) {
                    isNetworkImage = false;
                    signatureImageNetwork = "";
                    setState(() {});
                  } else {
                    if (signatureImage == null) {
                      _controller.toPngBytes().then((bytes) {
                        widget.onTapSaveSignature(bytes);
                      });
                    } else {
                      setState(() {
                        signatureImage = null;
                      });
                    }
                  }
                },
                text: isNetworkImage
                    ? (signatureImageNetwork.isEmpty)
                        ? S.of(context).save
                        : S.of(context).addNew
                    : (signatureImage == null)
                        ? S.of(context).save
                        : S.of(context).addNew,
                backgroundColor: F.isNiceTouch
                    ? ColorSchemes.ghadeerDarkBlue
                    : ColorSchemes.primary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomButtonWidget(
                backgroundColor: ColorSchemes.gray,
                onTap: () {
                  // if (widget.signatureImage == null) {
                  // widget.onTapClearSignature();
                  // _controller.clear();
                  // Navigator.pop(context);
                  // } else {
                  Navigator.pop(context);
                  // }
                  /*setState(() {
                    widget.signatureImage = Uint8List.fromList([]);
                  });*/
                },
                text: S.of(context).cancel,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }
}
