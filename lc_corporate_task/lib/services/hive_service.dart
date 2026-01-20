import 'package:hive/hive.dart';
import '../models/medicine_model.dart';

class HiveService {
  static const String _medicineBoxName = 'medicines';

  static Box<MedicineModel> get medicineBox =>
      Hive.box<MedicineModel>(_medicineBoxName);
}
