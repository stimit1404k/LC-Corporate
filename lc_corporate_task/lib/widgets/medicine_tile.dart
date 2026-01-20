import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineTile extends StatelessWidget {
  final MedicineModel medicine;

  const MedicineTile({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          medicine.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(medicine.dose),
        trailing: Text(TimeOfDay.fromDateTime(medicine.time).format(context)),
      ),
    );
  }
}
