class HiveProperties {
  static const int databaseVersion = 1;

  static const int toDoListID = 2;
  static const int workManagerID = 3;
  static const int invoiceManagerID = 4;
  static const int businessDetailsID = 5;
  static const int clientDetailsID = 6;
  static const int invoiceItemsID = 7;
  static const int bankDetailsID = 8;
  static const int employeeModelID = 9;
  static const int employeeTaskModelID = 10;
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

class HiveBusinessDetailsProperties {
  static const String TO_BUSINESS_DETAILS_DATA_BOX =
      "TO_BUSINESS_DETAILS_DATA_BOX";
  static const String TO_BUSINESS_DETAILS_DATA_KEY =
      "TO_BUSINESS_DETAILS_DATA_KEY";
  static const int businessID = 0;
  static const int businessName = 1;
  static const int businessFirstName = 2;
  static const int businessLastName = 3;
  static const int businessOwnerStreet = 4;
  static const int businessOwnerPostCode = 5;
  static const int businessOwnerCity = 6;
  static const int businessOwnerMobile = 7;
  static const int businessOwnerEmail = 8;
}

class HiveClientDetailsProperties {
  static const String TO_CLIENT_DETAILS_DATA_BOX = "TO_CLIENT_DETAILS_DATA_BOX";
  static const String TO_CLIENT_DETAILS_DATA_KEY = "TO_CLIENT_DETAILS_DATA_KEY";
  static const int clientID = 0;
  static const int clientFirstName = 1;
  static const int clientLastName = 2;
  static const int clientOwnerStreet = 3;
  static const int clientOwnerPostCode = 4;
  static const int clientOwnerCity = 5;
  static const int clientOwnerMobile = 6;
  static const int clientOwnerEmail = 7;
}

class HiveInvoiceItemsProperties {
  static const String TO_INVOICE_ITEMS_DATA_BOX = "TO_INVOICE_ITEMS_DATA_BOX";
  static const String TO_INVOICE_ITEMS_DATA_KEY = "TO_INVOICE_ITEMS_DATA_KEY";
  static const int itemID = 0;
  static const int description = 1;
  static const int quantity = 2;
  static const int itemPrice = 3;
  static const int totalItems = 4;
}

class HiveBankDetailsProperties {
  static const String TO_BANK_DETAILS_DATA_BOX = "TO_BANK_DETAILS_DATA_BOX";
  static const String TO_BANK_DETAILS_DATA_KEY = "TO_BANK_DETAILS_DATA_KEY";
  static const int bankID = 0;
  static const int bankName = 1;
  static const int sortCode = 2;
  static const int accountNo = 3;
}

class HiveEmployeeDetailsProperties {
  static const String TO_EMPLOYEE_DETAILS_DATA_BOX =
      "TO_EMPLOYEE_DETAILS_DATA_BOX";
  static const String TO_EMPLOYEE_DETAILS_DATA_KEY =
      "TO_EMPLOYEE_DETAILS_DATA_KEY";
  static const int employeeID = 0;
  static const int employeeFirstName = 1;
  static const int employeeLastName = 2;
  static const int employeeEmail = 3;
  static const int employeeRole = 4;
  static const int employeeHourlyRate = 5;
  static const int employeeDateJoined = 6;
  static const int employeeTaskList = 7;
}

class HiveEmployeeTaskProperties {
  static const String TO_EMPLOYEE_TASK_DATA_BOX = "TO_EMPLOYEE_TASK_DATA_BOX";
  static const String TO_EMPLOYEE_TASK_DATA_KEY = "TO_EMPLOYEE_TASK_DATA_KEY";
  static const int taskID = 0;
  static const int taskTitle = 1;
  static const int taskDescription = 2;
  static const int taskDuration = 3;
  static const int employeeID = 4;
  static const int employeeCheckInTime = 5;
  static const int employeeCheckOutTime = 6;
  static const int isDone = 7;
}
