# Party Glow - Flutter Party Decoration Services App

A beautiful Flutter application for party decoration services with a sophisticated beige-themed UI inspired by modern design principles.

## 📱 App Overview

Party Glow is a comprehensive party decoration services app that allows users to browse services, get quotes, and manage their party planning needs. The app features a clean, professional interface with smooth animations and intuitive navigation.

## 🏗️ Project Structure

\`\`\`
lib/
├── main.dart                    # App entry point and theme configuration
├── models/                      # Data models and business logic
│   ├── decoration_item.dart     # Decoration item model
│   └── service_item.dart        # Service item model
├── views/                       # Screen/page widgets (UI layers)
│   ├── intro_screen.dart        # Welcome/onboarding screen
│   ├── home_screen.dart         # Main dashboard with categories
│   ├── services_screen.dart     # Services listing and booking
│   └── profile_screen.dart      # User profile and settings
├── widgets/                     # Reusable UI components
│   ├── counter_widget.dart      # Happy clients counter with animation
│   ├── image_card.dart          # Reusable image display component
│   ├── custom_button.dart       # Standardized button component
│   └── category_chip.dart       # Category selection chips
└── services/                    # Business logic and data services
    ├── decoration_service.dart  # Decoration data management
    └── navigation_service.dart  # App navigation logic
\`\`\`

### 🎯 Architecture Rationale

**1. Separation of Concerns**
- **Models**: Pure data classes with no UI dependencies
- **Views**: Screen-level widgets that compose smaller widgets
- **Widgets**: Reusable UI components that can be used across screens
- **Services**: Business logic separated from UI concerns

**2. Scalability**
- Each folder has a specific responsibility
- New features can be added without affecting existing code
- Easy to locate and modify specific functionality

**3. Maintainability**
- Clear naming conventions
- Logical grouping of related files
- Minimal coupling between components

## 🌳 Widget Tree Hierarchy

\`\`\`
MaterialApp
└── IntroScreen (Initial)
    └── AnimatedContainer
        ├── Column
        │   ├── Image (Logo/Hero)
        │   ├── Text (Welcome message)
        │   └── CustomButton (Get Started)
        └── AnimatedPositioned (Decorative elements)

MainApp (After intro)
└── Scaffold
    ├── BottomNavigationBar
    │   └── BottomNavigationBarItem[] (Home, Services, Profile)
    └── IndexedStack (Page management)
        ├── HomeScreen
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── _buildHeader()
        │               │   └── Row
        │               │       ├── Column (Greeting text)
        │               │       └── CupertinoButton (Profile avatar)
        │               ├── CounterWidget
        │               │   └── AnimatedContainer
        │               │       ├── Text (Counter value)
        │               │       └── AnimatedBuilder (Happy face)
        │               ├── _buildSearchBar()
        │               │   └── Container
        │               │       └── TextField
        │               ├── _buildCategories()
        │               │   └── ListView.builder
        │               │       └── CategoryChip[]
        │               └── _buildFeaturedSection()
        │                   └── StaggeredGrid
        │                       └── _buildItemCard()[]
        │                           └── Container
        │                               ├── ImageCard
        │                               └── Column (Item details)
        ├── ServicesScreen
        │   └── SafeArea
        │       └── SingleChildScrollView
        │           └── Column
        │               ├── _buildHeader()
        │               └── ListView.builder
        │                   └── _buildServiceCard()[]
        │                       └── Container
        │                           ├── Stack (Image + Label)
        │                           └── Padding
        │                               └── Column (Service details)
        └── ProfileScreen
            └── SafeArea
                └── Column
                    ├── CircleAvatar (Profile image)
                    ├── Text (User info)
                    └── ListView (Profile options)
\`\`\`

## 🔧 Third-Party Packages Used

### flutter_staggered_grid_view
**Location**: `home_screen.dart` - Featured Items Section
**Purpose**: Creates a Pinterest-style staggered grid layout for decoration items
**Implementation**:
\`\`\`dart
StaggeredGrid.count(
  crossAxisCount: 2,
  mainAxisSpacing: 15,
  crossAxisSpacing: 15,
  children: filteredItems.map((item) {
    return _buildItemCard(item);
  }).toList(),
)
\`\`\`
**Why chosen**: Provides better visual hierarchy than regular GridView, making the decoration showcase more engaging and professional.

### flutter_animate
**Location**: Multiple screens for smooth transitions
**Purpose**: Adds professional animations and micro-interactions
**Implementation**: Fade-ins, slide animations, and staggered animations for list items

## 🎨 Design System

### Color Palette
- **Primary**: `Color(0xFF8B4513)` (Saddle Brown)
- **Background**: `Color(0xFFF5F5DC)` (Beige)
- **Accent**: `Color(0xFFD2B48C)` (Tan)
- **Surface**: `Colors.white`

### Typography
- **Headers**: Bold, 20-28px
- **Body**: Regular, 14-16px
- **Captions**: 12px with reduced opacity

## 🚀 Key Features

1. **Animated Counter**: Happy clients counter with emoji animation
2. **Category Filtering**: Dynamic content filtering by decoration type
3. **Quote System**: Comprehensive quote request forms
4. **Profile Management**: User profile with settings and preferences
5. **Responsive Design**: Optimized for various screen sizes
6. **Smooth Animations**: Professional micro-interactions throughout

## 🛠️ Development Setup

1. **Prerequisites**:
   - Flutter SDK (3.0+)
   - Dart SDK (3.0+)

2. **Installation**:
   \`\`\`bash
   flutter pub get
   flutter run
   \`\`\`

3. **Dependencies**:
   \`\`\`yaml
   dependencies:
     flutter_animate: ^4.2.0
     flutter_staggered_grid_view: ^0.6.2
   \`\`\`

## 📱 Screens Overview

- **IntroScreen**: Animated welcome screen with call-to-action
- **HomeScreen**: Dashboard with categories, search, and featured items
- **ServicesScreen**: Detailed service listings with booking functionality
- **ProfileScreen**: User management and app settings

## 🔄 State Management

The app uses Flutter's built-in state management with StatefulWidget for local state and service classes for business logic. This approach keeps the codebase simple while maintaining good separation of concerns.
