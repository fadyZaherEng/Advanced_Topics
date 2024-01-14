import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/doc_app.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/restart_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  
  runApp(const RestartWidget(DocApp()));
}
