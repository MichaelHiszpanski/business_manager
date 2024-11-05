class HiveProperties {
  static const int databaseVersion = 1;

  static const int toDoListID = 2;
  static const int workManagerID = 3;
  static const int invoiceManagerID = 4;
  static const int  businessDetailsID=5;
  static const int  clientDetailsID=6;
}

class HiveToDoListProperties {
  static const String TO_DO_LIST_DATA_BOX = "TO_DO_LIST_DATA_BOX";
  static const String TO_DO_LIST_DATA_KEY = "TO_DO_LIST_DATA_KEY";
  static const int id = 0;
  static const int title = 1;
  static const int content = 2;
  static const int dateTimeAdded = 3;
  static const int expiredDate = 4;
  static const int priority = 5;
}

class HiveWorkManagerProperties {
  static const String TO_WORK_MANAGER_DATA_BOX = "TO_WORK_MANAGER_DATA_BOX";
  static const String TO_WORK_MANAGER_DATA_KEY = "TO_WORK_MANAGER_DATA_KEY";
  static const int eventName = 0;
  static const int eventDescription = 1;
  static const int startDate = 2;
  static const int finishDate = 3;
  static const int backgroundColor = 4;
  static const int isAllDay = 5;
}

class HiveInvoiceManagerProperties {
  static const String TO_INVOICE_MANAGER_DATA_BOX = "TO_INVOICE_MANAGER_DATA_BOX";
  static const String TO_INVOICE_MANAGER_DATA_KEY = "TO_INVOICE_MANAGER_ATA_KEY";
  static const int id = 0;
  static const int title = 1;
  static const int content = 2;
  static const int dateTimeAdded = 3;
  static const int expiredDate = 4;
  static const int priority = 5;
}