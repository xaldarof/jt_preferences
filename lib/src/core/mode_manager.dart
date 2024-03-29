abstract class ModeManager {
  void startTemporaryMode();

  void stopTemporaryMode();

  Future<bool> sync();

  bool get isTemporaryModeEnabled;
}
