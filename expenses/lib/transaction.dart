int _idState = 0;

class Transaction {
  int id;
  final double amount;
  final DateTime date;
  final String description;
  Transaction({this.amount, this.description, this.date}) {
    if (this.amount == null || this.description == null || this.date == null) {
      return;
    }
    this.id = _idState;
    _idState++;
  }
}
