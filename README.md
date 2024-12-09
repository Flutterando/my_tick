# MyTick: A Study of the New Flutter Architecture

**MyTick** is a project designed to study and implement the new architecture proposed by the Flutter team. The repository contains two primary components:

1. **Server**: A backend server built with Dart and Shelf to handle authentication and task management.
2. **App**: A frontend application built with Flutter to consume the server's API and demonstrate architectural principles in practice.

## Structure

- `server/`: Contains the server implementation and a detailed `README.md` with instructions on how to run and test it.
- `app/`: Contains the Flutter app implementation that interacts with the server.

## Goals

This project aims to:

1. Demonstrate how to use the new architecture proposed by Flutter in a practical scenario.
2. Explore concepts such as separation of concerns, state management, dependency injection, and testing.
3. Provide a hands-on example of integrating a Flutter app with a Dart backend.

## Getting Started

### 1. Setting up the Server

Navigate to the `server/` directory and follow the instructions in its `README.md` to set up and run the backend server. The server handles:

- Authentication using JWT.
- Task management (CRUD operations).

### 2. Setting up the Flutter App

Navigate to the `app/` directory and follow the instructions in its `README.md` to set up and run the Flutter application. The app interacts with the server to:

- Authenticate users.
- Display, create, update, and delete tasks.

## Notes

- This project is intended for learning and demonstration purposes.
- The server uses in-memory storage for simplicity; for production, consider using a database.
- The architecture used in the Flutter app is modular and aligns with best practices to ensure scalability and maintainability.

Feel free to explore the repository and adapt it to your needs!

