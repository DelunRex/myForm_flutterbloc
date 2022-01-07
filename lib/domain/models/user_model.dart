class User {
  String? name, address, bankAccountNum, bankIfscCode;
  User({
    this.name,
    this.address,
    this.bankAccountNum,
    this.bankIfscCode,
  });

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
