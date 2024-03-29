// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:version_check/version_check.dart';

class ForceUpdateScreen extends BaseStatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends BaseState<ForceUpdateScreen> {
  VersionCheck versionCheck = VersionCheck();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await checkVersion();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Force Update'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkVersion() async {
    versionCheck = VersionCheck(
        packageName: Platform.isIOS
            ? 'com.example.flutterAdvancedTopics'
            : 'com.example.flutter_advanced_topics',
        showUpdateDialog: (context, versionCheck) => _showUpdateVersionDialog);
    await versionCheck.checkVersion(context);
  }

  void _showUpdateVersionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'NEW Update Available',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: ColorSchemes.primary),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'you must update the app to version ${versionCheck.packageVersion}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorSchemes.black),
                ),
                Text(
                  '(current version ${versionCheck.storeVersion})',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorSchemes.black),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Update Now',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorSchemes.primary),
              ),
              onPressed: () async {
                await versionCheck.launchStore();
              },
            ),
          ],
        );
      },
    );
  }
}
