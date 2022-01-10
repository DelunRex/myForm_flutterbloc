import '../../data/local/local_database_service.dart';
import '../../globals.dart';
import '../models/user_model.dart';

class UserRepository {
  UserRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;
//  final ApiService _apiService;  => For api calls if any

  User get currentUser {
    return _localStorageService.user;
  }

  bool get isUserLoggedIn => _localStorageService.isUserLoggedIn;
  bool get isFormDetailsSaved => _localStorageService.isFormDetailsSaved;

  Map<String, String> get bankDetails {
    final Map<String, String> map = <String, String>{};
    return map
      ..addAll(<String, String>{
        nameKey: currentUser.name!,
        addressKey: currentUser.address!,
        bankAccountNumKey: currentUser.bankAccountNum!,
        bankIfscCodeKey: currentUser.bankIfscCode!,
      });
  }

  set isFormDetailsSaved(bool value) =>
      _localStorageService.isFormDetailsSaved = value;

  void addFormDetails(
      String name, String address, String bankAccountNum, String bankIfscCode) {
    _localStorageService.user =
        currentUser.copyWith(name, address, bankAccountNum, bankIfscCode);
  }

  void registerUser(User user) {
    _localStorageService.user = user;
  }
}
