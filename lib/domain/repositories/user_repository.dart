import 'package:myform/data/local/local_database_service.dart';
import 'package:myform/domain/models/user_model.dart';
import 'package:myform/data/constants/app_assets.dart';

class UserRepository {
  final LocalStorageService _localStorageService;
//  final ApiService _apiService;  => For api calls if any
  UserRepository({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  User get currentUser {
    return _localStorageService.user;
  }

  bool get isUserLoggedIn => _localStorageService.isUserLoggedIn;
  bool get isFormDetailsSaved => _localStorageService.isFormDetailsSaved;

  Map<String, String> get bankDetails {
    Map<String, String> map = {};
    return map
      ..addAll({
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
