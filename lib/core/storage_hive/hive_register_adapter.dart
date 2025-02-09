import 'package:business_manager/core/storage_hive/color_adapter/color_adapter_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_details_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/employee_task_hive.dart';
import 'package:business_manager/feature/services/employee_management/data/hive/tasks_done_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/bank_hive/bank_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/business_hive/business_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/client_hive/client_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/invoice_items/invoice_items_hive.dart';
import 'package:business_manager/feature/services/to_do_list/data/to_do_hive/to_do_data_hive.dart';
import 'package:business_manager/feature/services/work_manager/data/hive/work_manager_hive.dart';
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
    if (!Hive.isAdapterRegistered(BusinessDetailsHiveAdapter().typeId)) {
      Hive.registerAdapter(BusinessDetailsHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(ClientsDetailsHiveAdapter().typeId)) {
      Hive.registerAdapter(ClientsDetailsHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(InvoiceItemsHiveAdapter().typeId)) {
      Hive.registerAdapter(InvoiceItemsHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(BankDetailsHiveAdapter().typeId)) {
      Hive.registerAdapter(BankDetailsHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(EmployeeDetailsHiveAdapter().typeId)) {
      Hive.registerAdapter(EmployeeDetailsHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(EmployeeTaskHiveAdapter().typeId)) {
      Hive.registerAdapter(EmployeeTaskHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(TasksDoneHiveAdapter().typeId)) {
      Hive.registerAdapter(TasksDoneHiveAdapter());
    }
  }
}
