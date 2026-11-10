enum AccountType {
  CASH('CASH', 'Cash'),
  BANK_ACCOUNT('BANK_ACCOUNT', 'Bank Account'),
  BANK_CARD('BANK_CARD', 'Bank Card'),
  BKASH('BKASH', 'bKash'),
  NAGAD('NAGAD', 'Nagad'),
  ROCKET('ROCKET', 'Rocket');

  final String apiValue;
  final String displayName;

  const AccountType(this.apiValue, this.displayName);
}
