import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPhoneNumberWidget extends StatelessWidget {
  final Function() editAction;
  final String phoneNumber;

  const EditPhoneNumberWidget({
    Key? key,
    required this.editAction,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            phoneNumber,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          const SizedBox(
            width: 13,
          ),
          GestureDetector(
            onTap: editAction,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.primary,
              ),
              child: Center(
                  child: SvgPicture.asset(
                ImagePaths.edit2,
                matchTextDirection: true,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
