# Party Glow - Flutter Layout Demo App

A comprehensive Flutter application demonstrating party decoration services with integrated layout examples from Activity 1 and Activity 2.

## Project Structure

\`\`\`
lib/
├── main.dart                    # App entry point and theme configuration
├── models/                      # Data models and business logic
│   └── decoration_item.dart     # Decoration and service item models
├── views/                       # Screen/page widgets (UI layers)
│   ├── intro_screen.dart        # Welcome/onboarding screen
│   ├── home_screen.dart         # Main dashboard with categories
│   ├── services_screen.dart     # Services listing and booking
│   ├── layout_demo_screen.dart  # Activity 2 layout demonstrations
│   └── main_navigation.dart     # Bottom navigation controller
├── widgets/                     # Reusable UI components
│   ├── counter_widget.dart      # Happy clients counter with animation
│   ├── image_card.dart          # Reusable image display component
│   ├── custom_button.dart       # Standardized button component
│   └── category_chip.dart       # Category selection chips
└── services/                    # Business logic and data services
    ├── decoration_service.dart  # Decoration data management
    ├── cart_service.dart        # Shopping cart functionality
    └── navigation_service.dart  # App navigation logic
\`\`\`

## Features

### Activity 1 Integration
- ✅ Organized folder structure (models, views, widgets, services)
- ✅ StatelessWidget Hello World app (PartyGlowApp)
- ✅ StatefulWidget with counter (CounterWidget)
- ✅ Custom reusable button widget (CustomButton)
- ✅ Material Design and Cupertino widgets implementation
- ✅ Multi-page app with bottom navigation
- ✅ Modular widget architecture
- ✅ Third-party packages (flutter_animate, google_fonts)
- ✅ Comprehensive project documentation

### Activity 2 Layout Demonstrations
1. **Row with Equal Spacing** - Three Text widgets with `MainAxisAlignment.spaceEvenly`
2. **Centered Column Buttons** - Two buttons centered vertically and horizontally
3. **Styled Container** - Container with padding, margin, and gradient background
4. **Profile Card Layout** - Row (profile picture + name) and Column (details)
5. **Responsive Layout** - Expanded widgets sharing screen width in Row
6. **Navigation Bar** - Row with icons spaced evenly using `MainAxisAlignment.spaceEvenly`
7. **Stack Layout** - Background with floating button overlay and positioned elements
8. **Flexible Layout** - Dynamic resizing with Flexible widgets in Column
9. **Chat Bubble UI** - Containers with padding, margin, and rounded borders
10. **Grid-like Layout** - Row and Column combination forming grid without GridView

### Additional Features
- **Cart Service Integration** - Singleton pattern for cart management
- **Animated UI Elements** - Using flutter_animate for smooth transitions
- **Theme Consistency** - Brown/tan color scheme throughout the app
- **Responsive Design** - Layouts adapt to different screen sizes
- **Interactive Elements** - Buttons, switches, and navigation with feedback

## Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone or download the project
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### For FlutLab.io
1. Create a new Flutter project on FlutLab.io
2. Copy all files from the `lib/` directory
3. Update `pubspec.yaml` with the required dependencies
4. Run the project

## Architecture Decisions

### Folder Organization
- **models/**: Data structures and business entities
- **views/**: Full-screen widgets and pages
- **widgets/**: Reusable UI components
- **services/**: Business logic and data management

This separation ensures:
- Clear separation of concerns
- Easy maintenance and testing
- Reusable components
- Scalable architecture

### Design Patterns
- **Singleton Pattern**: Used for CartService and DecorationService
- **StatefulWidget**: For interactive components requiring state management
- **StatelessWidget**: For static UI components
- **Provider Pattern**: Ready for state management scaling

### Layout Strategy
- **Flexbox First**: Using Row and Column for most layouts
- **Container Styling**: Consistent padding, margins, and decorations
- **Responsive Design**: Using Expanded and Flexible for adaptive layouts
- **Animation Integration**: Smooth transitions and micro-interactions

## Dependencies

\`\`\`yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0
  flutter_animate: ^4.2.0+1
\`\`\`

## License

This project is created for educational purposes as part of Flutter layout learning activities.
