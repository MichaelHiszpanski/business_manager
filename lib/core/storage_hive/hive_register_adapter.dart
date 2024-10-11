import 'package:dissertation_project_app/core/storage_hive/color_adapter/color_adapter_hive.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/data/to_do_hive/to_do_data_hive.dart';
import 'package:dissertation_project_app/feature/services/work_manager/data/hive/work_manager_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveRegisterAdapter {
  static Future<void> register() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(ToDoItemHiveAdapter().typeId)) {
      Hive.registerAdapter(ToDoItemHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(WorkManagerHiveAdapter().typeId)) {
      Hive.registerAdapter(WorkManagerHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(ColorAdapterHive().typeId)) {
      Hive.registerAdapter(ColorAdapterHive());
    }
  }
}
