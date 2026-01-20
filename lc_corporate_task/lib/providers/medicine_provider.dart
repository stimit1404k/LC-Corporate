import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/medicine_model.dart';
import '../services/notification_service.dart';

class MedicineProvider extends ChangeNotifier {
  final Box<MedicineModel> _box;

  MedicineProvider(this._box);

  List<MedicineModel> get medicines {
    final list = _box.values.toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    return list;
  }

  void addMedicine(MedicineModel medicine) {
    _box.add(medicine);
    notifyListeners();
  }

  Future<void> deleteMedicine(int index) async {
    final medicine = medicines[index];

    // cancel scheduled notification
    await NotificationService.cancelNotification(medicine.notificationId);

    // delete from Hive
    await _box.deleteAt(index);

    notifyListeners();
  }
}
