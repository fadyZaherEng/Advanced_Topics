import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_button_internet_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetWidget extends StatelessWidget {
  final Function() onTapTryAgain;

  const NoInternetWidget({required this.onTapTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorSchemes.border,
                  offset: Offset(0, 0),
                  blurRadius: 15),
            ],
            color: ColorSchemes.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagePaths.noInternet,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "No Internet Connection Found Check Your Connection",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorSchemes.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              CustomButtonInternetWidget(
                text: "try Again",
                onTap: () {
                  onTapTryAgain();
                },
                backgroundColor: ColorSchemes.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
