import 'package:flutter/material.dart';
import 'package:lc_corporate_task/screens/add_medicine_screen.dart';
import 'package:lc_corporate_task/widgets/medicine_tile.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_provider.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Reminder'),
        backgroundColor: AppColors.teal,
      ),
      body: Consumer<MedicineProvider>(
        builder: (context, provider, _) {
          if (provider.medicines.isEmpty) {
            return const Center(
              child: Text(
                'No medicines added yet',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.medicines.length,
            itemBuilder: (context, index) {
              final med = provider.medicines[index];

              return Dismissible(
                key: ValueKey(med.notificationId),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  context.read<MedicineProvider>().deleteMedicine(index);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Medicine deleted')),
                  );
                },
                child: MedicineTile(medicine: med),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMedicineScreen()),
          );
        },
      ),
    );
  }
}
