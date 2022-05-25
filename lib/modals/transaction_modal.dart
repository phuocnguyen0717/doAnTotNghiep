class TransactionModel {
  final int amount;
  final DateTime date;
  final String dropdownValue;
  final String type;

  TransactionModel(this.amount,this.date,this.dropdownValue,this.type);
  int get day {
    return date.day;
  }

  int get month {
    return date.month;
  }
}