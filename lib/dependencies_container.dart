import 'package:get_it/get_it.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/data/data_sources/local/index.dart';
import 'package:onthi_gplx_pro/features/user_management/data/repositories/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/repositories/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/index.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/license_bloc/license_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';

final sl = GetIt.instance;

void initialDependencies() {
  // D A T A B A S E
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // D A T A - S O U R C E S
  sl.registerLazySingleton<LocalUserDataSource>(
    () => LocalUserDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<LocalLicenseDataSource>(
    () => LocalLicenseDataSourceImpl(sl()),
  );

  // U S E C A S E S
  sl.registerLazySingleton<WatchCurrentUserUseCase>(
    () => WatchCurrentUserUseCase(sl()),
  );
  sl.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase(sl()));
  sl.registerLazySingleton<DeleteUserUseCase>(() => DeleteUserUseCase(sl()));

  sl.registerLazySingleton<GetLicenseByIdUseCase>(
    () => GetLicenseByIdUseCase(sl()),
  );
  sl.registerLazySingleton<GetLicensesUseCase>(() => GetLicensesUseCase(sl()));

  // R E P O S I T O R I E S
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<LicenseRepository>(
    () => LicenseRepositoryImpl(sl()),
  );

  // B L O C
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(watchCurrentUserUseCase: sl(), deleteUserUseCase: sl()),
  );
  sl.registerFactory<LicenseBloc>(() => LicenseBloc(sl()));
  sl.registerFactory<UserBloc>(
    () => UserBloc(createUserUseCase: sl(), deleteUserUseCase: sl()),
  );
}
