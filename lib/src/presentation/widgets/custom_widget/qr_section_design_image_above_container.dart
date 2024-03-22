import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/svg.dart';

class QrSection extends StatelessWidget {
  final Function() onTap;

  const QrSection({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: ColorSchemes.gray,
                    width: 1,
                  ),
                ),
                height: 125,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "S.of(context).createYourQrCode",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorSchemes.black, letterSpacing: -0.16),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                            "S.of(context).preregisterEntrantsUsingQrCodes",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "  userUnit.unitName",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(letterSpacing: -0.12),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                end: 3,
                bottom: 0,
                child: Container(
                  color: ColorSchemes.white,
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    ImagePaths.icPinCode,
                    height: 146,
                    width: 140,
                    matchTextDirection: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
