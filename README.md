# Weighted Autocomplete Search - GitHub User Search App

## Overview
This project follows the **Modern Android App Architecture** as outlined by [Google](https://developer.android.com/courses/pathways/android-architecture). It is built using **Flutter** and **Cubit** for state management, ensuring a clean separation of concerns and efficient state handling.

---

## 📌 Architecture & State Management

### 🏛 State Management
- Uses **Cubit** to handle application states (`loading`, `error`, `loaded`).
- Ensures a reactive and maintainable approach by separating business logic.

### ⚡ Service Locator
- Utilizes **get_it** for dependency injection and service management.
- Simplifies dependency management and promotes testability.

### 📦 Data Handling
- Implements **local caching** using **Hive**.
- Uses **REST API** for real-time data fetching.
- Supports **offline functionality** with cached results.

---

## 🔄 Repository Logic

### 🌐 Network Check
- The app first checks if an **internet connection** is available.
- If **offline**, it retrieves **cached data** (if available) or throws a network error.

### 🔁 Frequent Query Check
- A query is considered **frequent** if it appears **3 or more times**.
- All **constants** (e.g., `frequent search count`) are stored in `utils/constants`.

### 🔍 API Calls & Caching
- If **no cached data** is available, the app:
  1. Calls the **GitHub Search API**.
  2. Calls **users/{username} API** for the first **10 retrieved users**.
  3. If a user **frequently appears**, the app **skips API calls** and uses the cache.
- The **final sorted list** of users is returned.

---

## 📊 Sorting Logic (Handled in Cubit)
1. **Users with 50+ public repositories** are given higher priority.
2. **Users updated within the last 6 months** rank higher.

---

## 📦 Dependencies

### 🛠 State Management
- `flutter_bloc` - Handles state management using **Cubit**.

### 🔗 Dependency Injection
- `get_it` - Provides **service locator** for managing dependencies.

### 🗄 Local Storage
- `hive` - Used for **efficient local data caching** and as it quickly retrieve the cached results no need for await and performance wise.

### 🌍 Network Requests
- `dio` - Used for **handling API calls** to the GitHub API.

---
