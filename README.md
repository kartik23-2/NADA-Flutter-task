# Nada - Profiles & Mutual Connections

A production-grade, two-screen Flutter application built for the **Nada Network** assignment. The application enables users to browse matrimonial profiles, inspect demographic and background attributes, and understand mutual connection pathways (**"connected through"**).

---

## 📱 Features

### 1. Screen 1: Profiles Feed & Reactive Search
- **Live Search**: Case-insensitive filtering across both profile **name** and **city**.
- **State Management**: Asynchronous data loading with Riverpod (`FutureProvider` + reactive `Provider`).
- **Connection Badges**: Prominently highlights the mutual connection (`connected_through`) for each profile, or clearly states *"No connection yet"*.
- **Resilient States**:
  - **Loading**: Clean progress spinner while profiles are fetched.
  - **Empty State**: Dedicated *"No profiles match"* illustration when queries yield zero matches, with a one-tap button to reset search.
  - **Retryable Error**: Clear error banner with an interactive **"Try Again"** button to retry failed network requests.
- **Pull-to-Refresh**: Native `RefreshIndicator` for refreshing profiles on demand.

### 2. Screen 2: Detailed Profile View
- **Hero Header**: Initials avatar with gradient, full multi-line title handling long names without overflow, and demographic chips (`Age`, `Gender`, `City`, `Degree`).
- **Prominent Mutual Connection Banner**: Dedicated high-visibility pathway section showcasing `connected_through` with distinct badges.
- **Resilient Field Handling**:
  - Omission of missing keys (e.g. `education` which is absent for Dev Chaudhary).
  - Graceful handling of `null` values (`about`, `degree`, `connected_through`).
  - Native Devanagari (Hindi) Unicode support (e.g., *"आपके मौसा जी के बैंक के सहकर्मी।"*).
- **Responsive Layout**: Wrapped inside `SingleChildScrollView` to prevent keyboard or device dimension overflows.

---

## 🛠️ Architecture & Tech Stack

```text
lib/
├── main.dart                               # Entrypoint with ProviderScope
├── app.dart                                # MaterialApp configuration & theme
├── core/
│   ├── constants/
│   │   ├── api_endpoints.dart              # Gist endpoints
│   │   └── app_colors.dart                 # Brand palette & connection tokens
│   └── theme/
│       └── app_theme.dart                  # Material 3 theme & typography
└── features/
    └── profiles/
        ├── data/
        │   ├── models/
        │   │   └── profile_model.dart      # Resilient JSON deserialization & getters
        │   └── repositories/
        │       └── profile_repository.dart # Network client with UTF-8 decoding
        └── presentation/
            ├── providers/
            │   └── profile_providers.dart  # Riverpod asynchronous & filtered providers
            ├── screens/
            │   ├── profile_list_screen.dart
            │   └── profile_detail_screen.dart
            └── widgets/
                ├── connection_badge.dart
                ├── profile_card.dart
                ├── search_bar_widget.dart
                ├── error_view.dart
                └── empty_view.dart
```

- **Flutter**: 3.41.4+
- **State Management**: `flutter_riverpod` (v2.6.1)
- **Networking**: `http` (v1.3.0) with explicit `utf8.decode(response.bodyBytes)` to guarantee proper character rendering for Hindi/Devanagari scripts
- **Typography**: Google Fonts (Plus Jakarta Sans)
- **Testing**: `flutter_test`

---

## 🚀 Setup & Execution

### Prerequisites
- Flutter SDK installed (`flutter --version` >= 3.24)
- Google Chrome or Windows desktop build tools or an Android/iOS emulator

### 1. Clone & Install Dependencies
```bash
git clone <repository-url>
cd NADA
flutter pub get
```

### 2. Run the App
- **On Chrome (Web)**:
  ```bash
  flutter run -d chrome
  ```
- **On Windows (Desktop)**:
  ```bash
  flutter run -d windows
  ```
- **On Android / iOS Emulator**:
  ```bash
  flutter run
  ```

---

## 🧪 Running Tests

A comprehensive suite of 11 unit and widget tests verifies data edge cases, reactive search filtering, empty states, error recovery, and detail navigation:

```bash
flutter test
```

### What is tested:
1. **`profile_model_test.dart`**:
   - Safe parsing of full JSON profiles.
   - Missing keys resilience (e.g., omitted `education` key).
   - Null attribute handling (`degree: null`, `about: null`, `connected_through: null`).
   - UTF-8 Hindi (Devanagari) script integrity.
   - Initials generation for single and multi-word names.
2. **`profile_list_screen_test.dart`**:
   - Feed rendering with custom avatars and connection badges.
   - Live case-insensitive search by name (e.g. `ananya`).
   - Live case-insensitive search by city (e.g. `mumbai`).
   - Empty state verification (*"No profiles match"*).
   - Retryable error state verification.
   - Navigation to `ProfileDetailScreen` on card tap.

---

## 🔮 What I Would Do Next (With More Time)

1. **Offline Persistence & Local Caching**:
   - Implement local caching using `drift` or `hive` so profiles and connection graphs load instantly offline.
2. **Multi-Hop Connection Graph Visualization**:
   - Render an interactive node graph (using CustomPainter or Flutter GraphView) visually displaying the degrees of separation (e.g., *You -> Relative -> Mutual Friend -> Candidate*).
3. **Advanced Filtering & Sorting**:
   - Add filter chips for age range, community, education degree, and verified connections only.
4. **Favorites / Shortlist**:
   - Allow users to bookmark profiles locally with persistent storage.
5. **Golden UI Regression Tests**:
   - Add golden screenshot tests to catch visual regressions across different screen sizes.

---

## 🤖 AI Tools Disclosure
Assistance from generative AI tools (Google Gemini) was utilized during development for boilerplate scaffolding, architecture verification, and test case generation, adhering to modern software engineering best practices.
