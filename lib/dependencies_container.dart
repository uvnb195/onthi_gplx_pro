import 'package:get_it/get_it.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/app_database.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/dao/user_dao.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/local_user_data_source.dart';
import 'package:onthi_gplx_pro/data/data_sources/local/local_user_data_source_impl.dart';
import 'package:onthi_gplx_pro/data/repositories/user_repository_impl.dart';
import 'package:onthi_gplx_pro/domain/repositories/user_repository.dart';
import 'package:onthi_gplx_pro/domain/usercases/get_current_user.dart';
import 'package:onthi_gplx_pro/presentation/splash/bloc/splash_bloc.dart';

final sl = GetIt.instance;

void initialDependencies() {
  // D A T A B A S E
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // D A O
  sl.registerLazySingleton<UserDao>(() => UserDao(sl()));

  // U S E C A S E S
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl()),
  );

  // R E P O S I T O R I E S
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // D A T A - S O U R C E S
  sl.registerLazySingleton<LocalUserDataSource>(
    () => LocalUserDataSourceImpl(sl()),
  );
  // B L O C
  sl.registerFactory<SplashBloc>(() => SplashBloc(sl()));
}
