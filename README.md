# 📌 Pinterest Clone

A production-quality Flutter application demonstrating Pinterest-inspired UI, smooth animations, and clean architecture patterns.

## 📋 Overview

This project is a mobile application that replicates the core user experience of Pinterest, focusing on visual discovery, content curation, and intuitive interactions. The application emphasizes UI accuracy, performance optimization, and maintainable architecture over feature completeness.

The app demonstrates:

- 🖼️ **Pinterest-style masonry grid layouts** with dynamic image loading
- ✨ **Smooth, gesture-driven interactions** including long-press animations and contextual overlays
- 🏗️ **Clean Architecture** with clear separation between presentation, domain, and data layers
- 💾 **Cache-first data strategy** for instant content display and reduced network usage
- 🧭 **Independent navigation stacks** per tab to prevent unnecessary rebuilds
- ⚡ **Production-ready state management** with Riverpod and dependency injection

The scope focuses on UI polish, animation quality, and architectural decisions rather than backend infrastructure. All data is API-driven using Pexels for image content, with no local database dependencies.

## ✨ Key Features

### 🖼️ Pinterest-Style Masonry Feed
- Dynamic grid layout using `flutter_staggered_grid_view`
- Infinite scroll pagination with optimized image loading
- Smooth scrolling performance with aggressive image caching
- Pull-to-refresh with custom indicator animations

### 🔍 Search & Discovery Experience
- Real-time search with debounced API calls
- Trending searches and popular categories
- Discover feed with curated content sections
- Search results with instant cache display

### 📌 Save / Pin Interactions
- Long-press gesture detection on pins
- Contextual action overlay with smooth animations
- Save to board selection with bottom sheet
- Visual feedback with confetti animations on successful saves

### 🎬 Long-Press Contextual Animations
- Scale and fade transitions on pin interaction
- Contextual action menu overlay
- Smooth dismiss animations
- Hero transitions between feed and detail views

### 📱 Bottom Sheets & Overlays
- Custom bottom sheet implementations matching Pinterest design
- Smooth slide-up animations with backdrop blur
- Gesture-driven dismiss interactions
- Context-aware content presentation

### 🧭 Smooth Bottom Navigation
- Persistent AppShell using `StatefulNavigationShell`
- Independent navigation stacks per tab
- Zero flicker on tab switches
- Tab state persistence across app restarts

### 💾 Cache-First Behavior
- Images cached to disk using `cached_network_image`
- Feed data cached in memory with SharedPreferences backup
- Instant display of cached content on revisit
- No unnecessary network requests on tab switches

### 🔄 User-Driven Refresh Only
- No automatic refetching on screen re-entry
- Pull-to-refresh as the only data refresh mechanism
- Loading states only shown when cache is empty
- Prefers stale-but-visible content over blank screens

## 🛠️ Tech Stack

### Core Framework
- 🎯 **Flutter** - UI framework with Material 3 design system
- 💙 **Dart SDK** - ^3.9.2

### State Management & Architecture
- ⚡ **flutter_riverpod** (^2.4.9) - State management with compile-time safety
- 🔌 **get_it** (^7.6.7) - Dependency injection service locator
- 🔧 **injectable** (^2.3.2) - Code generation for dependency injection

### Navigation
- 🧭 **go_router** (^17.0.1) - Declarative routing with deep linking support

### Networking & Data
- 🌐 **dio** (^5.4.0) - HTTP client with interceptors
- 💾 **shared_preferences** (^2.2.2) - Local key-value storage
- 🔐 **flutter_dotenv** (^5.1.0) - Environment variable management

### UI Components
- 📐 **flutter_staggered_grid_view** (^0.7.0) - Masonry grid layout
- 🖼️ **cached_network_image** (^3.4.1) - Image caching with disk persistence
- 💿 **flutter_cache_manager** (^3.4.1) - Cache management utilities
- 🎬 **lottie** (^3.3.2) - Animation support for splash and interactions

### Authentication
- 🔑 **clerk_flutter** (^0.0.13-beta) - Authentication provider
- 🔐 **clerk_auth** (^0.0.11-beta) - Auth state management

### Code Generation & Utilities
- ❄️ **freezed** (^2.5.7) - Immutable data classes and unions
- 📄 **json_serializable** (^6.8.0) - JSON serialization
- 🧮 **fpdart** (^1.1.0) - Functional programming utilities
- 🔤 **google_fonts** (^6.2.1) - Poppins font family

### Platform Support
- 🤖 Android (API level 21+)
- 🍎 iOS (iOS 12+)

## 🏗️ Architecture Overview

The application follows **Clean Architecture** principles, organizing code into three distinct layers with clear dependency rules.

### Presentation Layer
Located in `features/*/presentation/`, this layer contains:
- **Pages** - Full-screen UI components
- **Widgets** - Reusable UI components
- **Providers** - Riverpod providers that expose state to UI
- **Notifiers** - State management logic using Riverpod's `StateNotifier`

The presentation layer depends only on the domain layer, never directly on data sources or external APIs.

### Domain Layer
Located in `features/*/domain/`, this layer contains:
- **Entities** - Core business objects (e.g., `Pin`, `User`, `Board`)
- **Repositories** - Abstract interfaces defining data operations
- **Use Cases** - Business logic that orchestrates repository calls

The domain layer is framework-agnostic and contains no Flutter-specific code. It defines the contracts that the data layer must implement.

### Data Layer
Located in `features/*/data/`, this layer contains:
- **Repository Implementations** - Concrete implementations of domain repository interfaces
- **Data Models** - API response models with JSON serialization
- **Data Sources** - Direct API clients and local storage access

The data layer implements domain contracts and handles all external dependencies (API calls, local storage, etc.).

### Why This Architecture?

✅ **Separation of Concerns**: Each layer has a single, well-defined responsibility. Business logic is isolated from UI and data access.

🧪 **Testability**: Domain layer can be tested without Flutter dependencies. Repository interfaces enable easy mocking for unit tests.

📈 **Scalability**: New features follow the same pattern, making the codebase predictable and maintainable.

🔄 **Flexibility**: Data sources can be swapped (e.g., switching APIs or adding offline support) without changing domain or presentation layers.

### Core Services

The `core/` directory contains shared infrastructure:
- **Network** - API client configuration, interceptors, error handling
- **Storage** - Local storage abstractions
- **Router** - Navigation configuration and route definitions
- **DI** - Dependency injection setup
- **Error Handling** - Centralized failure types and mappers

## ⚡ State Management Strategy

### Why Riverpod?

Riverpod was chosen for its compile-time safety, testability, and ability to manage complex state dependencies without the pitfalls of Provider's context-based access.

### State Scoping

**Feature-Level State**: Each feature manages its own state through dedicated providers:
- `feedProvider` - Home feed pins and pagination
- `searchProvider` - Search query and results
- `discoverProvider` - Discover feed content
- `savedPinsProvider` - User's saved pins collection

**App-Level State**: Shared state managed in `shared/providers/`:
- `navigationProvider` - Current tab index and navigation state
- `authStateProvider` - Authentication status and user data
- `appSkeletonProvider` - Loading skeleton visibility

### Minimizing Rebuilds

🎯 **Provider Overrides**: Initial state (e.g., last selected tab) is injected via provider overrides in `main.dart`, preventing router rebuilds on app start.

👁️ **Selective Watching**: UI widgets watch only the specific state they need, not entire provider trees.

📦 **State Notifiers**: Complex state logic is encapsulated in `StateNotifier` classes, keeping providers simple and focused.

🔀 **Independent Tab State**: Each tab maintains its own navigation stack and state, preventing cross-tab rebuilds.

## 🧭 Navigation Strategy

### Persistent AppShell

The app uses `StatefulNavigationShell` from go_router to create a persistent bottom navigation bar with independent navigation stacks per tab.

### IndexedStack / ShellRoute Usage

Each tab (Home, Search, Create, Notifications, Profile) has its own `Navigator` instance with a unique `GlobalKey`. This ensures:
- Tab state is preserved when switching tabs
- Navigation stacks are independent
- No screen rebuilds occur on tab switch
- Deep linking works correctly within each tab

### Independent Navigation Stacks

The router configuration uses separate navigator keys:
```dart
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
// ... etc
```

When a user navigates within a tab (e.g., Home → Pin Detail), only that tab's navigator is affected. Switching to another tab preserves the navigation state of all tabs.

### No Screen Rebuilds on Tab Switch

The router provider is built once with the initial tab index. Tab switching uses `StatefulNavigationShell.goBranch()` which updates the visible tab without rebuilding the router or other tabs' widgets.

### Pinterest-Like Navigation Flow

- **Feed → Pin Detail**: Hero transition with shared element animation
- **Pin Detail → Save to Board**: Bottom sheet overlay
- **Search → Results**: Push navigation with search query preservation
- **Profile → Saved Pins**: Nested navigation within profile tab

## 💾 Caching Strategy

### Image Caching Approach

🎯 **Cache-First Philosophy**: Images are cached to disk using `CachedNetworkImage` with a custom `PinterestCacheManager`. The same image URL never refetches unnecessarily.

⚡ **Aggressive Cache Limits**: Image cache is configured for 250 images / 200MB to support smooth scrolling through large grids. Cache limits are reduced when the app backgrounds to preserve memory.

🔑 **Stable Cache Keys**: Cache keys are based on image URLs only. No cache busting occurs from widget rebuilds or navigation.

💿 **Disk Persistence**: Images survive tab switches, scroll recycling, navigation, and app backgrounding. Cache is cleared only on memory pressure or app termination.

### Data Caching Approach

💭 **In-Memory Cache**: Feed data, search results, and discover content are cached in Riverpod providers. State persists as long as the provider is alive.

💾 **SharedPreferences Backup**: Critical state (last selected tab, auth status) is persisted to SharedPreferences for app restart recovery.

🚫 **No Automatic Refetch**: Data is never automatically refetched on:
- Tab switches
- Widget rebuilds
- Screen re-entry
- App foregrounding

🔄 **Intentional Refresh Only**: Users must explicitly pull-to-refresh to fetch new data. Cached data is displayed instantly while refresh happens in the background.

### Avoiding Unnecessary Refetches

♻️ **Provider Lifecycle**: Providers maintain state across navigation. A provider is only disposed when explicitly invalidated or when the app terminates.

👁️ **Cache-Aware Loading**: Loading states (skeletons, spinners) are shown only when cache is empty. Cached content displays immediately.

⏰ **Stale-but-Visible**: The app prefers showing cached content over blank loading states, even if the cache is potentially stale.

## 🎬 Animations & Interactions

### Design Philosophy

Animations follow Pinterest's design language: **calm, intentional, and finger-driven**. Every animation serves a purpose and responds directly to user input.

### Save / Pin Long-Press Animations

When a user long-presses a pin:
1. Pin scales down slightly (0.95x) with a smooth spring animation
2. Contextual action overlay fades in from the pin's position
3. Action buttons slide up with staggered timing
4. Backdrop dims to focus attention on actions

Releasing the press without selecting an action reverses the animation smoothly.

### Contextual Action Overlays

Action overlays appear at the pin's position, not centered on screen. This creates a direct connection between the pin and available actions. Overlays include:
- Save to board
- Share
- Report
- Copy link

### Bottom Sheet Animations

Bottom sheets use custom slide-up animations with:
- Spring physics for natural motion
- Backdrop blur for depth perception
- Gesture-driven dismiss (drag down to close)
- Content-aware sizing (e.g., board selection adapts to available boards)

### Refresh Animation Behavior

Pull-to-refresh uses a custom `PinterestRefreshIndicator` that:
- Shows Pinterest-branded loading animation
- Respects cache-first behavior (doesn't show spinner if cache exists)
- Provides haptic feedback on refresh trigger
- Smoothly transitions back to content on completion

## 🚀 Splash & Startup Flow

### Native Splash Screen Usage

The app uses `flutter_native_splash` to show a native splash screen immediately on app launch. The splash features:
- ⚫ Black background matching Pinterest's brand
- 🎯 Centered logo
- 📱 Platform-specific implementation (Android 12+ splash API, iOS launch screen)

### Flutter Splash with Animation

After the native splash, Flutter takes over and shows:
- Lottie animation (`splash_loading.lottie`) with Pinterest dots loader
- Smooth fade transition from native to Flutter splash
- Font preloading to prevent FOUT (Flash of Unstyled Text)

### App Initialization Flow

1. 🎨 **Native Splash Preserved**: `FlutterNativeSplash.preserve()` keeps native splash visible
2. 🔐 **Environment Variables Loaded**: API keys and configuration loaded from `assets/.env`
3. 🔌 **Dependencies Initialized**: get_it service locator configured with all dependencies
4. 🎨 **System UI Configured**: Status bar and navigation bar styled for splash screen
5. 🖼️ **Image Cache Configured**: Aggressive cache limits set for image-heavy usage
6. 🔤 **Fonts Prefetched**: Poppins font variants loaded to prevent FOUT
7. 🔑 **Auth State Checked**: Clerk authentication state resolved
8. 🧭 **Router Initialized**: GoRouter built with initial location from persisted tab state
9. 📰 **Feed Pre-initialized**: Feed provider accessed early to start loading cached data
10. ✨ **Splash Removed**: Native splash removed when app is fully ready

### Auth/Session Restoration

Authentication state is checked from two sources:
- 🔑 **Clerk Session**: Active session from Clerk SDK
- 💾 **Local Storage**: `isLoggedIn` flag from SharedPreferences for immediate navigation

This dual-check allows the app to navigate to the home feed immediately without waiting for Clerk's async session check, preventing auth flicker.

### No Auth Flicker on Restart

The app reads the last known auth state from SharedPreferences and overrides the initial router location accordingly. This ensures authenticated users never see the login screen on app restart, even briefly.

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point, initialization logic
├── app.dart                  # Root widget, theme configuration
│
├── core/                     # Shared infrastructure
│   ├── cache/               # Image cache configuration
│   ├── di/                  # Dependency injection setup
│   ├── error/               # Error handling and failure types
│   ├── network/             # API client, interceptors, services
│   ├── router/              # Navigation configuration
│   ├── storage/             # Local storage abstractions
│   ├── utils/               # Constants and utilities
│   └── widgets/             # Shared UI components
│
├── features/                 # Feature modules (Clean Architecture)
│   ├── auth/                # Authentication
│   │   ├── data/           # Clerk auth service wrapper
│   │   ├── domain/         # User entity, auth contracts
│   │   └── presentation/   # Login, register pages, auth gate
│   │
│   ├── home/                # Home feed
│   │   ├── data/           # Feed repository implementation
│   │   ├── domain/         # Feed repository interface, use cases
│   │   └── presentation/   # Feed page, providers, widgets
│   │
│   ├── search/              # Search and discovery
│   │   ├── data/           # Search repository, models
│   │   ├── domain/         # Search contracts, use cases
│   │   └── presentation/   # Search page, discover widgets
│   │
│   ├── pin/                 # Pin detail and interactions
│   │   ├── data/           # Pin repository implementation
│   │   ├── domain/         # Pin entity, repository interface
│   │   └── presentation/   # Pin viewer, save to board
│   │
│   ├── board/               # Board management
│   ├── inbox/               # Notifications and messages
│   ├── profile/             # User profile and saved content
│   └── onboarding/          # Post-login onboarding flow
│
└── shared/                   # Shared domain and state
    ├── domain/              # Shared entities (pagination, etc.)
    ├── notifiers/           # App-wide state notifiers
    ├── providers/           # Shared Riverpod providers
    ├── state/               # Shared state classes
    └── widgets/             # Shared UI components
```

### Responsibility of Major Folders

**`core/`**: Infrastructure code used across features. Contains no business logic, only technical implementations (networking, storage, routing, DI).

**`features/`**: Self-contained feature modules following Clean Architecture. Each feature can be developed and tested independently.

**`shared/`**: Code shared across multiple features but containing business logic (e.g., pagination entity, app-wide navigation state).

**`main.dart`**: Bootstrap logic only. No UI, no business logic. Handles initialization order and error boundaries.

**`app.dart`**: Root widget configuration. Theme, MaterialApp setup, auth wrapping. Minimal business logic.

## 🚀 How to Run the App

### Prerequisites

- 🎯 Flutter SDK ^3.9.2 or later
- 💙 Dart SDK ^3.9.2 or later
- 🛠️ Android Studio / Xcode for platform-specific builds
- 🖼️ Pexels API key (free at [pexels.com/api](https://www.pexels.com/api))
- 🔑 Clerk account and publishable key (for authentication)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pinterest
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   
   Create `assets/.env` file with the following:
   ```env
   PEXELS_API_KEY=your_pexels_api_key_here
   CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key_here
   ```
   
   ⚠️ **Note**: The `.env` file is gitignored. Never commit API keys or secrets.

4. **Run code generation** (if modifying freezed/json_serializable classes)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run on Android**
   ```bash
   flutter run
   ```
   Or specify a device:
   ```bash
   flutter run -d <device-id>
   ```

6. **Run on iOS**
   ```bash
   flutter run
   ```
   Ensure you have a valid iOS development certificate configured.

### Environment Variables

The app requires two environment variables in `assets/.env`:

- 🖼️ **PEXELS_API_KEY**: API key for Pexels image API
- 🔑 **CLERK_PUBLISHABLE_KEY**: Clerk publishable key for authentication

⚠️ If these are missing, the app will display an error message on startup.

### Platform-Specific Notes

🤖 **Android**: Minimum SDK version 21 (Android 5.0). Tested on Android 12+ with proper splash screen support.

🍎 **iOS**: Minimum iOS version 12.0. Requires valid provisioning profile for device runs.

## ⚠️ Limitations / Assumptions

### Intentionally Out of Scope

🌐 **Backend Infrastructure**: No custom backend. All data comes from Pexels API. User data (saved pins, boards) is stored locally only and not synced to a server.

⚡ **Real-Time Features**: No real-time updates for notifications, messages, or collaborative features. All data is fetched on-demand.

📴 **Offline Support**: While images are cached, the app requires network connectivity for data fetching. No offline-first data synchronization.

📤 **User-Generated Content**: Users cannot upload their own images. All content is sourced from Pexels.

👥 **Social Features**: No following, followers, or social interactions beyond saving pins locally.

### UI-Only or Mocked Features

🔔 **Notifications**: Inbox tab shows mock notification data. No real push notifications or message delivery.

👤 **User Profiles**: Profile data is read-only and sourced from Clerk authentication. No custom profile editing beyond Clerk's user management.

📋 **Boards**: Board creation and pin saving work locally. Boards are not shared or synced across devices.

🔍 **Search History**: Search queries are not persisted or used for recommendations.

### Simplifications Made

📄 **Pagination**: Infinite scroll uses simple page-based pagination. No cursor-based pagination or complex filtering.

🖼️ **Image Optimization**: Images are loaded at their original resolution. No dynamic image resizing or format optimization (WebP, AVIF).

❌ **Error Handling**: Network errors show generic messages. No retry logic or detailed error recovery flows.

📊 **Analytics**: No analytics or crash reporting integrated.

## 🔮 Future Improvements

### Features

- 📴 **Offline Support**: Implement local database (e.g., Hive, Isar) for offline pin browsing and board management
- 📤 **Image Upload**: Allow users to upload and pin their own images
- 🔗 **Board Sharing**: Enable sharing boards with other users
- 🔍 **Search History**: Persist search queries and show recent searches
- 🎯 **Recommendations**: Implement content recommendations based on saved pins
- 📚 **Collections**: Allow users to create and manage multiple boards as collections

### Performance Optimizations

- 🖼️ **Image Optimization**: Implement dynamic image resizing based on device pixel ratio and viewport size
- ⏳ **Lazy Loading**: Defer loading of non-visible content (e.g., related pins carousel)
- 💾 **Memory Management**: Implement more aggressive image cache eviction on low-memory devices
- ⚡ **Build Optimization**: Split app into feature modules for faster build times

### Testing Improvements

- 🧪 **Unit Tests**: Add comprehensive unit tests for domain layer (use cases, entities)
- 🎨 **Widget Tests**: Test critical UI components and user flows
- 🔗 **Integration Tests**: End-to-end tests for key user journeys (login, save pin, search)
- 🖼️ **Golden Tests**: Visual regression tests for UI components

### Architecture Enhancements

- 🏗️ **Repository Pattern Enhancement**: Add repository interfaces for local data sources
- 🔄 **Error Recovery**: Implement retry logic and exponential backoff for network requests
- 💾 **State Persistence**: Enhance state persistence beyond SharedPreferences (e.g., Hive for complex objects)
- 🔌 **Dependency Injection**: Consider using `injectable` code generation more extensively

### UX Polish

- 📳 **Haptic Feedback**: Add haptic feedback for key interactions (save, like, refresh)
- ⏳ **Loading States**: Improve loading skeleton designs to match Pinterest more closely
- 📭 **Empty States**: Add engaging empty states for empty boards, search results, etc.
- ♿ **Accessibility**: Improve screen reader support and accessibility labels

## 💭 Closing Note

This project demonstrates a commitment to craftsmanship in mobile app development. Every architectural decision, from Clean Architecture separation to cache-first data strategy, was made with long-term maintainability and user experience in mind.

The focus on UI accuracy, smooth animations, and performance optimization reflects an understanding that great apps are built through attention to detail. The Pinterest-inspired interactions—long-press gestures, contextual overlays, smooth navigation—are not just features but expressions of thoughtful UX design.

While the app may not include every feature of a production Pinterest app, it showcases the engineering discipline required to build one: clean code organization, efficient state management, and a user-first approach to performance and caching.

This codebase serves as both a portfolio piece demonstrating Flutter expertise and a learning resource for understanding how to structure large Flutter applications with Clean Architecture principles.
