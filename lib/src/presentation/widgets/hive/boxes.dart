import 'package:flutter_advanced_topics/src/presentation/widgets/hive/chat_history.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/settings.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/user_model.dart';

import 'package:hive/hive.dart';

class Boxes {
  // get the chat history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>("chatHistoryBox");

  // get user box
  static Box<UserModel> getUser() => Hive.box<UserModel>("userBox");

  // get settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>("settingsBox");
}
