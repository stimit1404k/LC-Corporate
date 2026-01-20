# 💊 Medicine Reminder App (Flutter)

A Flutter-based Medicine Reminder application that allows users to add their daily medicines, schedule reminders, and receive notifications even when the app is running in the background.

This project was built as part of a Flutter internship assignment, following clean architecture, proper state management, and strict UI constraints.

---

## ✨ Features

- 📋 View a list of daily medicines with:
  - Medicine name
  - Dose
  - Scheduled time
- ⏰ Add medicines using a time picker
- 🔔 Receive scheduled notifications (works in background)
- 🗑️ Swipe to delete medicines
  - Automatically cancels scheduled notifications
- 📦 Local data persistence (no backend)
- 🎨 Consistent UI using **Teal** as primary color and **Orange** for actions

---

## 🛠️ Tech Stack

- **Flutter**
- **Hive** – Local database
- **Provider** – State management
- **flutter_local_notifications** – Background notifications
- **timezone** – Accurate time-based scheduling

---

## 📁 Project Structure

```
lib/
├── main.dart
├── models/
│   └── medicine_model.dart
├── services/
│   ├── notification_service.dart
│   └── hive_service.dart
├── providers/
│   └── medicine_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── add_medicine_screen.dart
├── widgets/
│   └── medicine_tile.dart
└── utils/
    └── app_colors.dart
```

### Architecture Highlights

- **UI** is separated from **business logic**
- **Provider** handles all state updates
- **HiveService** abstracts database access
- **Reusable widgets** keep screens clean

---

## 🔔 Notification Logic

- Notifications are scheduled using `flutter_local_notifications`
- Timezone support ensures accurate triggering
- If the selected time has already passed for the day, the reminder is scheduled for the **next day**
- Notifications are cancelled automatically when a medicine is deleted

---

## 🧪 Validation & Edge Cases

- Empty form submission is not allowed
- Medicines are sorted by scheduled time
- Notifications only trigger for future times
- iOS notification permissions are handled explicitly

---

## ▶️ How to Run the Project

1. Clone the repository
2. Get dependencies:

   ```bash
   flutter pub get
   ```

3. Generate Hive adapters:

   ```bash
   dart run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

⚠️ **Important**: Make sure to allow notification permissions when prompted (especially on iOS).

---

## 🎥 Demo Video

▶️ **Watch the app demo here:**  
[Google Drive Video Link](https://drive.google.com/file/d/PASTE_YOUR_VIDEO_ID/view?usp=sharing)

> The video demonstrates adding a medicine, scheduling a reminder, receiving a notification, and deleting a medicine.

---

## 📄 License

This project is developed for educational purposes as part of a Flutter internship assignment.

---

## 👨‍💻 Author

Developed as part of a Flutter internship project.

---

**Note**: This is a local-only application. No backend or cloud synchronization is implemented.
