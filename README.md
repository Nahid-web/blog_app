# Blog Application

A modern blog application built with Flutter using Clean Architecture and BLoC pattern. This application supports both web and mobile platforms, utilizing Supabase as the backend service.

## 🏗️ Architecture

This project follows Clean Architecture principles with the following layers:

```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── widgets/
├── features/
│   └── blog/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
```

### Architecture Layers

- **Domain Layer**: Contains business logic and use cases
- **Data Layer**: Implements repositories and handles data sources
- **Presentation Layer**: Contains UI components and BLoC state management

## 🚀 Features

- Create, Read, Update, and Delete blog posts
- Image upload support for both web and mobile platforms
- Real-time updates using Supabase
- Responsive design for multiple screen sizes
- Clean and intuitive user interface

## 🛠️ Technical Stack

- **Framework**: Flutter
- **Architecture**: Clean Architecture
- **State Management**: BLoC Pattern
- **Backend**: Supabase
- **Storage**: Supabase Storage
- **Authentication**: Supabase Auth

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0
  supabase_flutter: ^latest_version
  equatable: ^2.0.0
  dartz: ^0.10.0
  get_it: ^7.0.0
  image_picker: ^latest_version
  cached_network_image: ^latest_version
```

## 🔧 Setup and Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/blog_app.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Supabase:
   - Create a Supabase project
   - Update `lib/core/constants/supabase_constants.dart` with your credentials:
```dart
class SupabaseConstants {
  static const String SUPABASE_URL = 'YOUR_SUPABASE_URL';
  static const String SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
}
```

4. Run the application:
```bash
flutter run
```

## 📁 Project Structure

### Core
- **constants/**: Application-wide constants
- **errors/**: Custom error handling
- **utils/**: Utility functions and helpers
- **widgets/**: Reusable widgets

### Features/Blog
- **data/**
  - **datasources/**: Remote and local data sources
  - **models/**: Data models and DTOs
  - **repositories/**: Repository implementations
- **domain/**
  - **entities/**: Core business objects
  - **repositories/**: Repository interfaces
  - **usecases/**: Business logic use cases
- **presentation/**
  - **bloc/**: BLoC state management
  - **pages/**: Screen implementations
  - **widgets/**: Feature-specific widgets

## 🔄 State Management

The application uses BLoC pattern with the following states:

```dart
// Example Blog States
abstract class BlogState extends Equatable {
  const BlogState();
}

class BlogInitial extends BlogState {}
class BlogLoading extends BlogState {}
class BlogLoaded extends BlogState {}
class BlogError extends BlogState {}
```

## 🖼️ Image Handling

The application handles image upload differently for web and mobile platforms:

- **Web**: Uses `Uint8List` for image data
- **Mobile**: Uses `File` for image data

## 🔐 Security

- Secure file upload using Supabase Storage
- Protected API endpoints
- Proper error handling and validation

## 🧪 Testing

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 📱 Supported Platforms

- Android
- iOS
- Web

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- Flutter team
- Supabase team
- BLoC library contributors
