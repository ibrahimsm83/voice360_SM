import 'package:injectable/injectable.dart';
import 'package:itp_voice/repo/auth_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/storage_keys.dart';

@lazySingleton
class NumbersService {
  AuthRepo authRepo = AuthRepo();
  List<String> chatNumbers = <String>[];

  String getCurrentCallNumber() {
    String? numberFromStorage = SharedPreferencesMethod.storage.getString(StorageKeys.CURRENT_CALL_NUMBER);
    if (numberFromStorage != null && numberFromStorage.toString().isNotEmpty) {
      return numberFromStorage;
    } else if (chatNumbers.isNotEmpty) {
      return chatNumbers[0];
    }
    return '+18637580072';
  }

  getUpdatedNumbersList() async {
    try {
      chatNumbers = await authRepo.getChatNumbers();
    } catch (e) {
      if (e == "401") {
        throw ("401");
      }
    }
  }
}
