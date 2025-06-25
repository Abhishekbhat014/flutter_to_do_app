class NotificationStorage {
  static final List<String> _notifications = [];

  static List<String> get notifications => _notifications;

  static void add(String message) {
    _notifications.insert(0, message);
  }
}
