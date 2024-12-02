import 'package:flutter_advanced_topics/src/presentation/widgets/notification_service/notification_service_with_fcm_rest_api/fcm_rest_api_new/send_notification_service.dart';

void sendNotification() async {
  //add user as subscriber to request id
  await SendNotificationService.subscribeToGroup(
    "50",
    "event.sender.userInformation.id.toString()",
  );

// //send notification
// await SendNotificationService.sendMassageByToken(
//   requestId: event.requestId.toString(),
//   message: "${event.sender.userInformation.fullName} is send message : ${event.message}",
// );
//send notification
  await SendNotificationService.sendMassageByTopic(
    topic: "topic${50}",
    unitId: 10,
    requestId: "50",
    message:
        "${"event.sender.userInformation.fullName"} is send message : ${"event.message"}",
  );
}
