// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/user_management/data/data_sources/local/index.dart'
    as _i937;
import '../../features/user_management/data/data_sources/local/license_data_source.dart'
    as _i193;
import '../../features/user_management/data/data_sources/local/user_data_source.dart'
    as _i737;
import '../../features/user_management/data/repositories/license_repository_impl.dart'
    as _i197;
import '../../features/user_management/data/repositories/user_repository_impl.dart'
    as _i362;
import '../../features/user_management/domain/repositories/index.dart' as _i245;
import '../../features/user_management/domain/repositories/user_repository.dart'
    as _i462;
import '../../features/user_management/domain/usecases/create_user.dart'
    as _i315;
import '../../features/user_management/domain/usecases/delete_user.dart'
    as _i591;
import '../../features/user_management/domain/usecases/get_license_by_id.dart'
    as _i896;
import '../../features/user_management/domain/usecases/get_licenses.dart'
    as _i48;
import '../../features/user_management/domain/usecases/index.dart' as _i743;
import '../../features/user_management/domain/usecases/watch_current_user.dart'
    as _i867;
import '../../features/user_management/presentation/bloc/license_bloc/license_bloc.dart'
    as _i704;
import '../../features/user_management/presentation/bloc/user/user_bloc.dart'
    as _i172;
import '../database/app_database.dart' as _i982;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i982.AppDatabase>(() => registerModule.database);
    gh.lazySingleton<_i737.LocalUserDataSource>(
      () => _i737.LocalUserDataSourceImpl(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i193.LocalLicenseDataSource>(
      () => _i193.LocalLicenseDataSourceImpl(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i245.UserRepository>(
      () => _i362.UserRepositoryImpl(gh<_i937.LocalUserDataSource>()),
    );
    gh.lazySingleton<_i245.LicenseRepository>(
      () => _i197.LicenseRepositoryImpl(gh<_i937.LocalLicenseDataSource>()),
    );
    gh.factory<_i896.GetLicenseByIdUseCase>(
      () => _i896.GetLicenseByIdUseCase(gh<_i245.LicenseRepository>()),
    );
    gh.factory<_i48.GetLicensesUseCase>(
      () => _i48.GetLicensesUseCase(gh<_i245.LicenseRepository>()),
    );
    gh.factory<_i591.DeleteUserUseCase>(
      () => _i591.DeleteUserUseCase(gh<_i462.UserRepository>()),
    );
    gh.factory<_i315.CreateUserUseCase>(
      () => _i315.CreateUserUseCase(gh<_i462.UserRepository>()),
    );
    gh.factory<_i172.UserBloc>(
      () => _i172.UserBloc(
        createUserUseCase: gh<_i315.CreateUserUseCase>(),
        deleteUserUseCase: gh<_i591.DeleteUserUseCase>(),
      ),
    );
    gh.factory<_i867.WatchCurrentUserUseCase>(
      () => _i867.WatchCurrentUserUseCase(gh<_i245.UserRepository>()),
    );
    gh.factory<_i704.LicenseBloc>(
      () => _i704.LicenseBloc(gh<_i743.GetLicensesUseCase>()),
    );
    gh.factory<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        watchCurrentUserUseCase: gh<_i743.WatchCurrentUserUseCase>(),
        deleteUserUseCase: gh<_i743.DeleteUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
