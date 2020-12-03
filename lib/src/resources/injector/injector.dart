import 'package:get_it/get_it.dart';
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  SharedPreferencesManager sharedPreferencesManager =
      await SharedPreferencesManager.getInstance();
  locator.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager);
}
