import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomRadioListTileWidget extends StatelessWidget {
  final int groupValue;
  final String imagePath;
  final String title;
  final int id;
  final Function(dynamic) onChange;

  const CustomRadioListTileWidget({
    Key? key,
    required this.title,
    required this.id,
    required this.groupValue,
    required this.onChange,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(width: 8),
            Text(title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                    )),
            const Expanded(child: SizedBox()),
            RadioButtonWidget(
              value: id,
              groupValue: groupValue,
              onChanged: onChange,
            )
          ],
        ),
      ),
    );
  }
}
