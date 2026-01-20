import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine_model.dart';
import '../providers/medicine_provider.dart';
import '../services/notification_service.dart';
import '../utils/app_colors.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();

  TimeOfDay? _selectedTime;

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveMedicine() {
    if (_nameController.text.isEmpty ||
        _doseController.text.isEmpty ||
        _selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are required')));
      return;
    }

    final now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final medicine = MedicineModel(
      name: _nameController.text.trim(),
      dose: _doseController.text.trim(),
      time: scheduledTime,
      notificationId: notificationId,
    );

    context.read<MedicineProvider>().addMedicine(medicine);

    NotificationService.scheduleNotification(
      id: notificationId,
      title: 'Medicine Reminder',
      body: '${_nameController.text} - ${_doseController.text}',
      time: scheduledTime,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        backgroundColor: AppColors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: _doseController,
              decoration: const InputDecoration(
                labelText: 'Dose (e.g. 1 tablet)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'No time selected'
                        : _selectedTime!.format(context),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                  ),
                  onPressed: _pickTime,
                  child: const Text('Pick Time'),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                ),
                onPressed: _saveMedicine,
                child: const Text('Save Medicine'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
