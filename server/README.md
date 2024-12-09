# Server: MyTick

This is a simple API for managing tasks with authentication using JWT, built with Dart and Shelf.

## Requirements

Before starting, ensure you have the following installed on your system:

- [Dart SDK](https://dart.dev/get-dart)

## How to Run

1. Go to `server` folder:
   ```bash
   cd server
   ```

2. Install the dependencies:
   ```bash
   dart pub get
   ```

3. Generate models:
   ```bash
   dart run realm_dart generate

4. Install database dll/so:
   ```bash
   dart run realm_dart install
   ```

5. Run the server:
   ```bash
   dart run
   ```

6. The server will start on `http://localhost:8080`. Test using [Swagger](http://localhost:8080)


## Swagger Documentation

This API is documented using OpenAPI/Swagger. You can find the documentation in the `specs/swagger.yaml` file.

### How to View the Documentation

1. Access [http://localhost:8080/docs](http://localhost:8080/docs)


## Notes

- The tasks and user data are stored in memory for simplicity.
- This API is for demonstration and learning purposes; for production, consider using a database and securing the JWT secret.

