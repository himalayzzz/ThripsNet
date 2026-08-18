# Frontend — mobile app (Flutter)

Purpose
-------
The frontend is a Flutter mobile application used by farmers to capture leaf photos, confirm seed variety, view local risk heatmaps and receive alerts.

Local development
-----------------
Prereqs: Flutter SDK, Android Studio / VS Code.

Run on an Android device/emulator:

```powershell
flutter pub get
flutter run
```

Notes for model integration
---------------------------
- On-device inference uses TensorFlow Lite models stored in `assets/` (`tswv_best_model.tflite`).
- For end-to-end testing, point the app to a local `backend/` instance (see `backend/README.md`).

Testing & localization
----------------------
- The app supports multiple languages — update locale resources under `lib/` and `assets/`.
- Add widget tests under `test/` and run them with `flutter test`.
