import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:podcastapp/core/di/service_locator.config.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
  await sl.init();
}
