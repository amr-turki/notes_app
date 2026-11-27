# 📝 Smart Notes Application

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Hive](https://img.shields.io/badge/HiveDB-FF6F00?style=for-the-badge&logo=databricks&logoColor=white)](https://pub.dev/packages/hive)
[![BLoC/Cubit](https://img.shields.io/badge/State_Management-BLoC%2FCubit-blueviolet?style=for-the-badge)](https://pub.dev/packages/flutter_bloc)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A sleek, fast, and feature-rich **Notes Application** built with **Flutter**. Designed with an **offline-first** approach, it leverages **Hive NoSQL Database** for local persistence and **BLoC / Cubit** for reactive, clean, and scalable state management.

---

## ✨ Features Overview

- 🚀 **Offline-First Persistence**: Instant local read/write operations with **Hive**.
- ⚡ **Reactive State Management**: Clean separation of business logic and UI using **Flutter BLoC / Cubit**.
- 🎨 **Pastel Color Palette**: Assign custom colors to individual notes for visually appealing organization.
- 🔍 **Real-Time Search**: Instant filtering across stored notes by title and body content.
- 🌗 **Adaptive Dynamic Theme**: Smooth toggling between Light Mode and Dark Mode.
- 🖐️ **Interactive Gestures**: Slide-to-edit and slide-to-delete actions integrated with `flutter_slidable`.

---

## 🛠️ Key Engineering & Refactoring Highlights

Recent refactoring focused on performance optimization, code clean-up, memory management, and production-ready architecture:

- 🛑 **Memory Leak Prevention:** Refactored `TextEditingController` instances in `AddNote` and `EditNote` screens to manage them within stateful lifecycles with explicit `dispose()` cleanup.
- ⚡ **Hive Initialization Order Fix:** Corrected Hive initialization sequence in `main.dart` by executing `await Hive.initFlutter()` prior to registering adapters and opening boxes to prevent runtime boot crashes.
- 🔑 **Key-Based Hive Mutations:** Updated delete and edit operations to target unique Hive `keys` instead of list indices, eliminating data corruption risks during active search filtering.
- 🧩 **State Decoupling & Clean Architecture:** Replaced static mutable color states in `ColorPickers` with typed callbacks (`ValueChanged<Color>`) for predictable UI updates.
- 🗺️ **Navigation Stack Safety:** Fixed navigation loops by replacing redundant `Navigator.push` calls back to Home with proper `Navigator.pop()`, preventing RAM bloat and duplicate page stacks.
- 💬 **User-Friendly Exception Mapping:** Replaced raw technical error strings with translated, user-friendly error messages in `NotesCubit`.

---

## 🏗️ Project Architecture & File Structure

The project follows clean coding standards, naming conventions, and feature-based modular design:

```text
lib/
├── cubits/               # State management logic (NotesCubit & NotesState)
│   ├── notes_cubit.dart
│   └── notes_state.dart
├── helper/               # App constants and static configurations (AppAssets)
│   └── app_assets.dart
├── models/               # Data Layer: Custom TypeAdapters & Hive Models
│   └── notes.dart
└── views/                # Presentation Layer: Screens & Modular UI Widgets
    ├── about_us.dart
    ├── add_note.dart
    ├── edit_note.dart
    ├── home_screen.dart
    ├── navigation_drawer.dart
    ├── settings.dart
    ├── splash_screen.dart
    └── widgets/          # Reusable custom UI widgets
        ├── color_pickers.dart
        ├── custom_text_field.dart
        ├── note_item.dart
        └── search_bar.dart