import 'dart:async';

class MyStreamsController {

  StreamController<bool> notificationCountController =
      StreamController<bool>();
  Stream<bool> get notificationCountStream =>
      notificationCountController.stream;

  disposeNotificationCountStream() {
    if (notificationCountController != null)
      notificationCountController.close();
  }
}
