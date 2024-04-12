class AppSingleton {
  AppSingleton._();

  static final AppSingleton _instance = AppSingleton._();

  factory AppSingleton() => _instance;

  bool _showUpdateDialog = true;

  void setShowUpdateDialog (bool value) {
    _showUpdateDialog = value;
  }

  bool getShowUpdateDialog () {
    return _showUpdateDialog;
  }
}
