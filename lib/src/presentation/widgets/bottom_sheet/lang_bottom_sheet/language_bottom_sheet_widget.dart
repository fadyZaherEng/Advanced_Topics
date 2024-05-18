import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/bottom_sheet/lang_bottom_sheet/lang.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_radio_button_widget.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  final List<Language> languages;
  final Language selectedLanguage;
  final Function(Language) onLanguageSelected;
  final ScrollPhysics? scrollPhysics;

  const LanguageBottomSheetWidget({
    Key? key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: scrollPhysics,
      itemCount: languages.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => onLanguageSelected(languages[index]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        languages[index].name,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagePaths.flagPlaceHolder,
                            fit: BoxFit.fill,
                            width: 24,
                            height: 24,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      languages[index].name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: Constants.fontWeightRegular,
                            letterSpacing: -0.24,
                            color:
                                selectedLanguage.code == languages[index].code
                                    ? ColorSchemes.primary
                                    : ColorSchemes.gray,
                          ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadioButtonWidget(
                      isSelected:
                          selectedLanguage.code == languages[index].code,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: index != languages.length - 1,
              child: Container(
                height: 0.6,
                width: double.infinity,
                color: ColorSchemes.border,
              ),
            )
          ],
        );
      },
    );
  }
}
