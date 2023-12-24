import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/styles.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    print(hasMinLength);
    return Column(
      children: [
        buildValidationRow('Password must not be empty', hasMinLength),
        const SizedBox(
          height: 3,
        ),
        buildValidationRow('At least 1 lowercase letter', hasLowerCase),
        const SizedBox(
          height: 3,
        ),
        buildValidationRow('At least 1 uppercase letter', hasUpperCase),
        const SizedBox(
          height: 3,
        ),
        buildValidationRow(
            'At least 1 special character', hasSpecialCharacters),
        const SizedBox(
          height: 3,
        ),
        buildValidationRow('At least 1 number', hasNumber),
        const SizedBox(
          height: 3,
        ),
        buildValidationRow('At least 8 characters long', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: ColorSchemes.gray,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? ColorSchemes.gray : ColorSchemes.darkBlue,
          ),
        )
      ],
    );
  }
}
