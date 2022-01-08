class User {
  User({
    this.name,
    this.address,
    this.bankAccountNum,
    this.bankIfscCode,
  });

  String? name, address, bankAccountNum, bankIfscCode;

  User copyWith(
      String name, String address, String bankAccountNum, String bankIfscCode) {
    return User(
      name: name,
      address: address,
      bankAccountNum: bankAccountNum,
      bankIfscCode: bankIfscCode,
    );
  }
}
