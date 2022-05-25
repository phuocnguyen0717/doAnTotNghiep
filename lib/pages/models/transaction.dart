class TransactionModel {
  int amount;
  final String dropdownValue;
  final DateTime date;
  final String type;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  TransactionModel(this.amount, this.dropdownValue, this.date, this.type);
}
