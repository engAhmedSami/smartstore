# SmartStore 🛒

A Flutter-based shopping application built using Flutter and Firebase. This project provides a robust foundation for e-commerce applications with clean architecture, real-time data management, and secure authentication.

## ✨ Features

- Fully functional shopping app with Firebase integration
- User and Admin apps for better store management
- Secure authentication with Firebase Authentication
- Real-time database updates using Firestore
- Clean and modern UI with dynamic themes
- State management using Provider
- Image storage with Firebase Storage
- Supports portrait mode for better user experience

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart
- Android Studio or VS Code (with Flutter and Dart plugins)
- Git
- Firebase setup for authentication, Firestore, and storage

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/engAhmedSami/SmartStore.git
   cd SmartStore
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Configure Firebase:
   - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the respective directories.
   - Enable Firebase Authentication and Firestore.

4. Run the app:
   ```sh
   flutter run
   ```

## 🏗️ Project Structure

This project follows clean architecture principles with well-separated layers:

### **1. Presentation Layer**
- Handles UI using Flutter widgets
- State management with Provider and ChangeNotifier

### **2. Domain Layer**
- Defines the business logic and use cases
- Contains abstract repositories and core entities

### **3. Data Layer**
- Fetches and stores data from Firebase Firestore and Storage
- Uses repositories and data sources for structured data access

## 📌 Notes & Limitations

- The project is designed for **Windows configurations** (iOS configurations are not covered but support is available).
- **Apps are built for portrait mode only** (landscape mode is not supported).
- Resources and documentation are included for guidance.

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request.

## 🏆 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ahmed Sami**  
📧 [ii.ahmedsami0@gmail.com](mailto:ii.ahmedsami0@gmail.com)  
🔗 [LinkedIn](http://www.linkedin.com/in/ahmedsami011) | [GitHub](https://github.com/engAhmedSami)

---

⭐ **Star the repository if you find it useful!**
