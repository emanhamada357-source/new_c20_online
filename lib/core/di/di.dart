
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_c20_online/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();