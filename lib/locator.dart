import 'package:get_it/get_it.dart';
import 'package:itp_voice/services/numbers_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NumbersService());
}
