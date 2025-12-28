# cuarta_ruta_app

A mobile app to manage brackets, formats, and voting for rap battles.

## Prerequisites: Setup with FVM
This project uses **FVM** to manage the Flutter SDK version. After cloning the repository, follow these steps:

1. **Install FVM** (only if you don't have it):
   dart pub global activate fvm

2. **Install the required Flutter version**: FVM will automatically detect the version from `.fvmrc`.
    fvm install
3. **Set the project SDK**: This ensures your local environment points to the correct version.
    fvm use
4. **Run commands**: Always use the fvm prefix for Flutter commands.
    fvm flutter pub get
    fvm flutter run