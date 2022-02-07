# House of Auctions

House of Auctions is made to provide an auction environment for those willing to sell their items or looking to buy products with a user-friendly interface.

## Getting Started and Building Instructions

1. Download and install flutter from https://flutter.dev/ (make sure you have android studio installed)
2. Open the project with android studio or vscode
3. Open an android emulator, or if you wish to run the app on a real device, plug in your phone (make sure usb debugging is enabled)
4. Run `flutter pub get` to get the packages
5. Run `flutter pub run build_runner build` to generate required files
6. To run the app connected to local server, run `flutter run --release`, to run the app connected to heroku server, run `flutter run --dart-define=APP_ENV=prod --release`. (When running locally, make sure to update your ip at assets/config/dev.json)
