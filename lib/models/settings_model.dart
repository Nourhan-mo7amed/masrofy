class SettingsModel {
  bool notifications;
  bool darkMode;
  String language;

  SettingsModel({
    this.notifications = true,
    this.darkMode = false,
    this.language = "English",
  });
}
