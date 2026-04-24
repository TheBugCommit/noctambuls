import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/core/services/external_service_link.dart';
import 'package:noctambuls/core/services/external_service_link_impl.dart';

void initServices() {
  sl.registerLazySingleton<ExternalLinkService>(ExternalLinkServiceImpl.new);
}
