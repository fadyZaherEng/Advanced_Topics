import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_empty_list_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final bool isHaveBackButton;
  final Function()? onBackButtonPressed;
  final String emptyMessage;
  final String assetName;
  final Function() onRefresh;

  const EmptyScreen({
    Key? key,
    required this.title,
    required this.isHaveBackButton,
    this.onBackButtonPressed,
    required this.emptyMessage,
    required this.assetName,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarWidget(
          context,
          title: title,
          isHaveBackButton: isHaveBackButton,
          onBackButtonPressed: onBackButtonPressed ?? () {},
        ),
        body: CustomEmptyListWidget(
          imagePath: assetName,
          text: emptyMessage,
          onRefresh: () {
            onRefresh();
          },
        ));
  }
}
