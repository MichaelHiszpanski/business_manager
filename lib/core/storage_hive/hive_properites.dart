class HiveProperties {
  static const int databaseVersion = 1;

  static const int toDoListID = 2;
  static const int workManagerID = 3;
  static const int invoiceManagerID = 4;
  static const int businessDetailsID = 5;
  static const int clientDetailsID = 6;
  static const int invoiceItemsID = 7;
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
  static const int businessName = 0;
  static const int businessFirstName = 1;
  static const int businessLastName = 2;
  static const int businessOwnerStreet = 3;
  static const int businessOwnerPostCode = 4;
  static const int businessOwnerCity = 5;
  static const int businessOwnerMobile = 6;
  static const int businessOwnerEmail = 7;
}

class HiveClientDetailsProperties {
  static const String TO_CLIENT_DETAILS_DATA_BOX = "TO_CLIENT_DETAILS_DATA_BOX";
  static const String TO_CLIENT_DETAILS_DATA_KEY = "TO_CLIENT_DETAILS_DATA_KEY";
  static const int clientFirstName = 0;
  static const int clientLastName = 1;
  static const int clientOwnerStreet = 2;
  static const int clientOwnerPostCode = 3;
  static const int clientOwnerCity = 4;
  static const int clientOwnerMobile = 5;
  static const int clientOwnerEmail = 6;
}

class HiveInvoiceItemsProperties {
  static const String TO_INVOICE_ITEMS_DATA_BOX = "TO_INVOICE_ITEMS_DATA_BOX";
  static const String TO_INVOICE_ITEMS_DATA_KEY = "TO_INVOICE_ITEMS_DATA_KEY";
  static const int description = 0;
  static const int quantity = 1;
  static const int itemPrice = 2;
  static const int totalItems = 3;
}
