# App: MyTick

This is the frontend application for the **MyTick** project, built using Flutter. It consumes the server API and serves as a practical implementation of the new architecture proposed by the Flutter team.

## About the Architecture

Flutter's new architecture focuses on separation of concerns, modularity, and testability. The app uses the following principles:

- **UI Layer**: Contains the widgets and declarative user interface.
- **Domain Layer**: Handles the business logic and core functionality.
- **Data Layer**: Manages access to remote and local data sources.

For more details, refer to the official Flutter documentation:

- [App Architecture Overview](https://docs.flutter.dev/app-architecture)
- [Concepts](https://docs.flutter.dev/app-architecture/concepts)
- [Guide](https://docs.flutter.dev/app-architecture/guide)
- [Recommendations](https://docs.flutter.dev/app-architecture/recommendations)
- [Case Study](https://docs.flutter.dev/app-architecture/case-study)

## How to Run

1. Navigate to the `app/` directory:
   ```bash
   cd flutter_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

Ensure the server is running before launching the app. Refer to the `server/README.md` for setup instructions.

## Features

- **Authentication**: Login using the server's API and JWT.
- **Task Management**: Create, view, update, and delete tasks.

## Notes

- This app is intended for learning and demonstration purposes.
- The architecture is designed to align with Flutter's best practices for scalability and maintainability.

