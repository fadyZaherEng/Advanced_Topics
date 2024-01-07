import 'package:permission_handler/permission_handler.dart';

class PermissionServiceHandler {
  Future<bool> handleServicePermission({required Permission setting}) async {
    await setting.status;
    final result = await setting.request();

    switch (result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }
}
