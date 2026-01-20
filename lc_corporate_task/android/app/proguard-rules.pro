# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**

# Keep Android notification classes
-keep class androidx.core.app.NotificationCompat** { *; }
-dontwarn androidx.core.app.NotificationCompat**
