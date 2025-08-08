# Event App 📅

A comprehensive Flutter event management application that allows users to create, manage, and discover events with location-based features and multi-language support.

## 📱 What This App Does

**Event App** is a full-featured mobile application that enables users to:

- **Create and Manage Events**: Users can create personalized events with details like title, description, date, time, category, and location
- **Discover Events**: Browse events created by the user with category-based filtering
- **Location Integration**: View events on an interactive map with markers showing event locations
- **User Authentication**: Secure sign-in/sign-up with email/password and Google authentication
- **Multilingual Support**: Switch between English and Arabic languages
- **Theme Customization**: Toggle between light and dark themes with persistent settings
- **Favorites Management**: Mark and manage favorite events
- **Real-time Updates**: Live synchronization with Firebase for instant updates

## 🏗️ Project Architecture

The project follows **Clean Architecture** principles with a modular structure:

```
lib/
├── core/                    # Core functionality and shared resources
│   ├── constants/          # App constants (colors, sizes, strings, images)
│   ├── models/            # Data models (EventModel, UserModel)
│   ├── route/             # Navigation and routing
│   ├── services/          # Business logic services
│   ├── theme/             # Theme configuration
│   └── widgets/           # Reusable UI components
├── features/              # Feature-based architecture (future expansion)
├── l10n/                  # Localization files
├── modules/               # Main app modules
│   ├── authentication/    # Login, Register, Forgot Password
│   ├── event/            # Event creation and management
│   ├── favourite/        # Favorites functionality
│   ├── home/             # Home screen with event listing
│   ├── map/              # Map view with event markers
│   ├── onBoarding/       # App introduction screens
│   ├── profile/          # User profile management
│   └── splash/           # Splash screen
├── layout.dart           # Main app layout with bottom navigation
└── main.dart            # App entry point
```

## 🛠️ Technologies & Packages Used

### **Core Framework**
- **Flutter SDK** (^3.7.2) - Cross-platform mobile development
- **Dart** - Programming language

### **State Management**
- **Provider** (^6.1.2) - State management solution
- **AppSettingProvider** - Manages theme and locale settings

### **Backend & Database**
- **Firebase Core** (^2.30.0) - Firebase initialization
- **Firebase Auth** (^4.17.0) - User authentication
- **Cloud Firestore** (^4.15.0) - NoSQL database for events and users
- **Firebase Storage** (^11.7.0) - File storage
- **Firebase Messaging** (^14.8.0) - Push notifications

### **Authentication**
- **Google Sign-In** (^6.1.6) - Google OAuth integration
- Email/Password authentication via Firebase Auth

### **Local Storage**
- **SharedPreferences** (^2.5.3) - Local data persistence
- **LocalStorgeServices** - Custom abstraction layer for SharedPreferences

### **Maps & Location**
- **Google Maps Flutter** (^2.12.3) - Interactive maps
- **Geolocator** (^12.0.0) - Location services and permissions
- **Geocoding** (^4.0.0) - Address to coordinates conversion

### **Internationalization**
- **Flutter Localizations** (SDK) - Built-in localization support
- **Intl** - Internationalization utilities
- **Custom L10n** - English and Arabic language support

### **UI & UX**
- **Cupertino Icons** (^1.0.8) - iOS-style icons
- **Awesome Dialog** (^3.2.1) - Beautiful dialog boxes
- **Flutter EasyLoading** (^3.0.5) - Loading indicators
- **Animated Custom Dropdown** (^3.1.1) - Enhanced dropdown widgets
- **Smooth Page Indicator** (^1.2.1) - Page indicators for onboarding

### **Development Tools**
- **Flutter Lints** (^5.0.0) - Linting rules
- **Flutter Launcher Icons** (^0.13.1) - App icon generation

## 🎨 Theme System

The app features a comprehensive theming system:

### **Color Palette**
- **Primary**: `#4b68ff` (Blue)
- **Secondary**: `#FFE24B` (Yellow)
- **Accent**: `#b0c7ff` (Light Blue)
- **Light Background**: `#F6F6F6`
- **Dark Background**: `#101127`

### **Typography**
- **Font Family**: Inter (Bold, Italic, Regular)
- **Responsive text scaling** for different screen sizes
- **Light and dark variants** for optimal readability

### **Component Themes**
- AppBar themes (light/dark)
- Elevated button themes
- Text field themes
- Checkbox themes
- Bottom navigation themes

## 🌍 Localization Features

### **Supported Languages**
- **English (en)** - Default language
- **Arabic (ar)** - RTL support included

### **Localized Elements**
- All UI text and labels
- Error messages
- Form validation messages
- Navigation labels
- Authentication screens

### **Implementation**
- **ARB files** for translation management
- **Auto-generated** localization classes
- **Runtime language switching**
- **Persistent language selection**

## 💾 Local Storage Implementation

### **LocalStorgeServices** (Custom Implementation)
```dart
// Save theme preference
LocalStorgeServices.setBool(LocalStorgeKey.isDark, true);

// Save locale preference
LocalStorgeServices.setString(LocalStorgeKey.locale, 'ar');

// Load saved settings
bool? isDark = LocalStorgeServices.getBool(LocalStorgeKey.isDark);
String? locale = LocalStorgeServices.getString(LocalStorgeKey.locale);
```

### **Persistent Settings**
- **Theme preference** (light/dark mode)
- **Language selection** (English/Arabic)
- **First-time app launch** flag
- **User preferences** and app state

## 🗂️ Key Services

### **AppSettingProvider**
```dart
// Theme management
void toggleTheme()
void setThemeMode(ThemeMode mode)

// Locale management
void toggleLocale()
void setLocale(Locale newLocale)

// Settings persistence
Future<void> loadSettings()
```

### **AuthService**
- Email/password authentication
- Google Sign-In integration
- User session management

### **EventFireBaseFireStore**
- CRUD operations for events
- Real-time event streaming
- User-specific event filtering
- Category-based event queries

### **UserService**
- User profile management
- Firestore user data operations
- User authentication state

### **AppDataService**
- Current user data management
- Location services
- App-wide data sharing

## 📍 Map Integration

### **Features**
- **Interactive Google Maps** with custom markers
- **Current location** detection and display
- **Event location markers** with info windows
- **Real-time marker updates** when events change
- **Location permissions** handling

### **Implementation**
- Custom marker icons for different types
- Optimized marker management to prevent performance issues
- Location-based event filtering

## 🔐 Authentication System

### **Supported Methods**
1. **Email/Password** - Traditional authentication
2. **Google Sign-In** - OAuth integration
3. **Password Reset** - Email-based recovery

### **User Management**
- Automatic Firestore user profile creation
- Session persistence
- Secure user data handling

## 📱 App Screens & Navigation

### **Authentication Flow**
- **Splash Screen** - App initialization
- **Onboarding** - First-time user introduction
- **Login/Register** - Authentication screens
- **Forgot Password** - Password recovery

### **Main App Flow**
- **Home** - Event listing with category filters
- **Map** - Geographic event view
- **Add Event** - Event creation form
- **Event Details** - Detailed event information
- **Favorites** - Saved events management
- **Profile** - User settings and preferences

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / Xcode
- Firebase project setup

### **Installation**

1. **Clone the repository**
```bash
git clone <repository-url>
cd event_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
- Create a Firebase project
- Add Android/iOS apps to Firebase
- Download and place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Enable Authentication, Firestore, and Storage

4. **Run the app**
```bash
flutter run
```

## 📂 Where to Edit

### **Adding New Features**
- Create new modules in `lib/modules/`
- Add corresponding routes in `lib/core/route/`
- Update navigation in `lib/layout.dart`

### **Modifying Themes**
- Colors: `lib/core/constants/colors.dart`
- Text styles: `lib/core/theme/widget_themes/text_theme.dart`
- Component themes: `lib/core/theme/widget_themes/`

### **Adding Translations**
- English: `lib/l10n/app_en.arb`
- Arabic: `lib/l10n/app_ar.arb`
- Run `flutter gen-l10n` to generate translation classes

### **Database Models**
- Event model: `lib/core/models/event_model.dart`
- User model: `lib/core/models/user_model.dart`

### **Services & Business Logic**
- Authentication: `lib/core/services/auth_services.dart`
- Events: `lib/core/services/event_services.dart`
- Settings: `lib/core/services/app_setting_provider.dart`

## 🎯 Key Features in Detail

### **Event Management**
- Create events with rich details
- Category-based organization
- Date and time scheduling
- Location integration
- Image attachments (banner selection)

### **Real-time Synchronization**
- Live event updates via Firestore streams
- Automatic UI refresh on data changes
- Offline capability with Firebase caching

### **User Experience**
- Smooth animations and transitions
- Loading states and error handling
- Responsive design for different screen sizes
- Accessibility considerations

### **Performance Optimizations**
- Efficient marker management on maps
- Lazy loading of events
- Image optimization
- Memory management

## 🤝 Contributing

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Support

For support and questions, please contact the development team or create an issue in the repository.

---

**Built with ❤️ using Flutter and Firebase**