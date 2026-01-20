import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lc_corporate_task/services/hive_service.dart';
import 'package:provider/provider.dart';

import 'models/medicine_model.dart';
import 'providers/medicine_provider.dart';
import 'screens/home_screen.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MedicineModelAdapter());
  await Hive.openBox<MedicineModel>('medicines');

  tz.initializeTimeZones();
  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MedicineProvider>(
      create: (_) => MedicineProvider(HiveService.medicineBox),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicine Reminder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
