import 'package:flutter_advanced_topics/src/presentation/widgets/hive/boxes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/chat_history.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/message.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/settings.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/hive/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveMethods {
  // init Hive box
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter("DocDB");

    // register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());

      // open the chat history box
      await Hive.openBox<ChatHistory>("chatHistoryBox");
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      await Hive.openBox<UserModel>("userBox");
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<Settings>("settingsBox");
    }
  }

  // save messages to hive db
  Future<void> saveMessagesToDB({
    required String chatID,
    required Message userMessage,
    required Message assistantMessage,
    required Box messagesBox,
  }) async {
    // save the user messages
    await messagesBox.add(userMessage.toMap());

    // save the assistant messages
    await messagesBox.add(assistantMessage.toMap());

    // save chat history with thae same chatId
    // if its already there update it
    // if not create a new one
    final chatHistoryBox = Boxes.getChatHistory();

    final chatHistory = ChatHistory(
      chatId: chatID,
      prompt: userMessage.message.toString(),
      response: assistantMessage.message.toString(),
      imagesUrls: userMessage.imagesUrls,
      timestamp: DateTime.now(),
    );
    await chatHistoryBox.put(chatID, chatHistory);

    // close the box
    await messagesBox.close();
  }

  // load messages from db
  Future<List<Message>> loadMessagesFromDB({
    required String chatId,
  }) async {
    // open the box of this chatID
    await Hive.openBox('${"chatMessagesBox"}$chatId');

    final messageBox = Hive.box('${"chatMessagesBox"}$chatId');

    final newData = messageBox.keys.map((e) {
      final message = messageBox.get(e);
      final messageData = Message.fromMap(Map<String, dynamic>.from(message));

      return messageData;
    }).toList();
    // notifyListeners();
    return newData;
  }

  // delete chat messages
  Future<void> deleteChatMessages({
    required String chatId,
  }) async {
    // 1. check if the box is open
    if (!Hive.isBoxOpen('${"chatMessagesBox"}$chatId')) {
      // open the box
      await Hive.openBox('${"chatMessagesBox"}$chatId');

      // delete all messages in the box
      await Hive.box('${"chatMessagesBox"}$chatId').clear();

      // close the box
      await Hive.box('${"chatMessagesBox"}$chatId').close();
    } else {
      // delete all messages in the box
      await Hive.box('${"chatMessagesBox"}$chatId').clear();

      // close the box
      await Hive.box('${"chatMessagesBox"}$chatId').close();
    }
  }

  Future<void> deleteAllChats() async {
    await Hive.deleteBoxFromDisk("chatHistoryBox");
    await Hive.deleteBoxFromDisk("chatMessagesBox");
    await Hive.deleteBoxFromDisk("userBox");
    await Hive.deleteBoxFromDisk("settingsBox");
  }
}
