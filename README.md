# Nada - Profiles & Connections

A two-screen Flutter application built for the Nada Network take-home assignment. It allows users to browse matrimonial profiles and understand mutual connections ("connected through").

## Tech Stack
- **Flutter** (Channel stable, 3.41.4+)
- **Dart** (3.11.1+)
- **State Management**: Riverpod (`flutter_riverpod`)
- **Networking**: `http`
- **Typography**: Google Fonts

## Features
- Network fetch from live JSON dataset with full UTF-8 decoding (Hindi text support).
- Screen 1: Profile list with real-time case-insensitive search by name and city.
- Loading state, empty state ("No profiles match"), and retryable error state.
- Screen 2: Detailed profile view with prominent `connected_through` banner and robust handling of missing/null fields.
- Zero text overflow and resilient layout design.
- Comprehensive widget and unit tests.
