// First Way  (Mandatory)
// using //https://appupgrade.dev/projects and app_upgrade_flutter_sdk
// app_upgrade_flutter_sdk need xApikey that i can get it from //https://appupgrade.dev/projects
//
// Second Way (Mandatory)
// using package https://pub.dev/packages/in_app_update
//
//
// Third Way (Mandatory)
// using app_version_update :
// https://pub.dev/packages/app_version_update
//
// there are another way but not mandatory only option show to the user


//############################################################################


//first way
// app_upgrade_flutter_sdk:
//with https://appupgrade.dev/projects/65e9a6a1672d490012260e65/view to get xApiKey
//dependencies:
// cupertino_icons: ^1.0.2
// app_upgrade_flutter_sdk: ^1.0.4
// packages_info:

import 'dart:io';

import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//
// class UpdateCheck extends StatefulWidget {
//   @override
//   _UpdateCheckState createState() => _UpdateCheckState();
// }
//
// class _UpdateCheckState extends State<UpdateCheck> {
//   String currentVersion = '';
//   String latestVersion =
//       ''; // Fetch this value from your backend or a service that provides the latest version
//
//   @override
//   void initState() {
//     super.initState();
//     _checkVersion();
//   }
//
//   Future<void> _checkVersion() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     setState(() {
//       currentVersion = packageInfo.version;
//     });
//
//     // Compare the current version with the latest version
//     if (currentVersion != latestVersion) {
//       _showUpdateDialog();
//     }
//   }
//
//   void _showUpdateDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Available'),
//           content: Text(
//               'A new version of the app is available. Please update to continue using the app.'),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Update Now'),
//               onPressed: () {
//                 // Redirect the user to the App Store/Play Store
//                 // You need to replace 'your_app_id' with your app's ID on the respective app store
//                 // Also, replace the link with your app's actual link on the app store
//                 // For iOS:
//                 // LaunchAppStore().launchAppStore('your_app_id');
//                 // For Android:
//                 // LaunchAppStore().launchAppStore('your_package_name');
//                 // Make sure to handle exceptions and provide fallbacks
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Check'),
//       ),
//       body: Center(
//         child: Text('Current Version: $currentVersion'),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: UpdateCheck(),
//   ));
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppInfo appInfo = AppInfo(
        appName: 'flutter_force_update',
        // Your app name
        appVersion: '1.0.2',
        // Your app version
        platform: Platform.operatingSystem,
        // App Platform, android or ios
        environment: 'development',
        // Environment in which app is running, production, staging or development etc.
        appLanguage: 'en' // App language ex: en, es etc. Optional.
    );

    DialogConfig dialogConfig = DialogConfig(
      dialogStyle: DialogStyle.material,
      title: 'App update required!',
      updateButtonTitle: 'Update Now',
      laterButtonTitle: 'Later',
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: AppUpgradeAlert(
          xApiKey: 'NTExZGE0M2ItNGZjNC00MTAyLTk2M2EtZjBkMWMwMmYyNzBj',
          appInfo: appInfo,
          dialogConfig: dialogConfig,
          child: const Center(
            child: Text(
              'Flutter Demo Home Page',
            ),
          ),
        ),
      ),
    );
  }
}

//second way using app_version_update :
//https://pub.dev/packages/app_version_update


//third way using in_app_update :
//https://pub.dev/packages/in_app_update


