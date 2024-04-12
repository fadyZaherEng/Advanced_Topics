// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/source/local/singleton/app/app_singleton.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/utils/check_app_version.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mandatory_update/update_version/utils/launch_store.dart';

class ForceUpdateScreen extends BaseStatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends BaseState<ForceUpdateScreen> {
  final AppSingleton _appSingleton = AppSingleton();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_appSingleton.getShowUpdateDialog() &&
        F.appFlavor == Flavor.production) {
      try {
        await checkVersion(
          context: context,
          isMandatory: false,
          onTapUpdate: () async {
            //Todo if it's Mandatory don't set it to false
            _appSingleton.setShowUpdateDialog(false);
            Navigator.pop(context);
            launchStore();
          },
          onSkipTab: () {
            Navigator.pop(context);
            _appSingleton.setShowUpdateDialog(false);
          },
        );
      } catch (e) {
        //Todo Handle Error State
      }
    }
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
}
