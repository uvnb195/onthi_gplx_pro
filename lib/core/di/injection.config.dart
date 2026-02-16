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
import '../../features/learning/data/data_sources/local/category_data_source.dart'
    as _i602;
import '../../features/learning/data/data_sources/local/question_data_source.dart'
    as _i295;
import '../../features/learning/data/repositories/question_category_repository_impl.dart'
    as _i121;
import '../../features/learning/data/repositories/question_repository_impl.dart'
    as _i969;
import '../../features/learning/domain/repositories/question_category_repository.dart'
    as _i764;
import '../../features/learning/domain/repositories/question_repository.dart'
    as _i359;
import '../../features/learning/domain/usecases/get_all_question_categories.dart'
    as _i214;
import '../../features/learning/domain/usecases/get_question_categories_by_license.dart'
    as _i246;
import '../../features/learning/domain/usecases/get_question_category_by_id.dart'
    as _i1050;
import '../../features/learning/domain/usecases/get_random_questions.dart'
    as _i307;
import '../../features/learning/domain/usecases/index.dart' as _i106;
import '../../features/learning/domain/usecases/update_question_status.dart'
    as _i569;
import '../../features/learning/domain/usecases/watch_questions_by_category.dart'
    as _i707;
import '../../features/learning/presentation/bloc/learning_bloc.dart' as _i591;
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
import '../../features/user_management/domain/repositories/license_repository.dart'
    as _i182;
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
import '../database/dao/category/category_dao.dart' as _i377;
import '../database/dao/question/question_dao.dart' as _i742;
import '../database/dao/user/user_dao.dart' as _i391;
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
    gh.lazySingleton<_i377.CategoryDao>(
      () => _i377.CategoryDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i742.QuestionDao>(
      () => _i742.QuestionDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i391.UserDao>(
      () => _i391.UserDao(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i295.LocalQuestionDataSource>(
      () => _i295.LocalQuestionDataSourceImpl(gh<_i742.QuestionDao>()),
    );
    gh.lazySingleton<_i602.LocalCategoryDataSource>(
      () => _i602.LocalCategoryDataSourceImpl(gh<_i377.CategoryDao>()),
    );
    gh.lazySingleton<_i737.LocalUserDataSource>(
      () => _i737.LocalUserDataSourceImpl(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i193.LocalLicenseDataSource>(
      () => _i193.LocalLicenseDataSourceImpl(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<_i764.QuestionCategoryRepository>(
      () => _i121.QuestionCategoryRepositoryImpl(
        localCategoryDataSource: gh<_i602.LocalCategoryDataSource>(),
      ),
    );
    gh.lazySingleton<_i214.GetAllQuestionCategoriesUseCase>(
      () => _i214.GetAllQuestionCategoriesUseCase(
        gh<_i764.QuestionCategoryRepository>(),
      ),
    );
    gh.lazySingleton<_i246.GetQuestionCategoriesByLicenseUseCase>(
      () => _i246.GetQuestionCategoriesByLicenseUseCase(
        gh<_i764.QuestionCategoryRepository>(),
      ),
    );
    gh.lazySingleton<_i1050.GetQuestionCategoriesByIdUseCase>(
      () => _i1050.GetQuestionCategoriesByIdUseCase(
        gh<_i764.QuestionCategoryRepository>(),
      ),
    );
    gh.lazySingleton<_i359.QuestionRepository>(
      () => _i969.QuestionRepositoryImpl(gh<_i295.LocalQuestionDataSource>()),
    );
    gh.lazySingleton<_i569.UpdateQuestionStatusUseCase>(
      () => _i569.UpdateQuestionStatusUseCase(gh<_i359.QuestionRepository>()),
    );
    gh.lazySingleton<_i707.WatchQuestionsByCategoryUseCase>(
      () =>
          _i707.WatchQuestionsByCategoryUseCase(gh<_i359.QuestionRepository>()),
    );
    gh.lazySingleton<_i245.UserRepository>(
      () => _i362.UserRepositoryImpl(gh<_i937.LocalUserDataSource>()),
    );
    gh.lazySingleton<_i182.LicenseRepository>(
      () => _i197.LicenseRepositoryImpl(gh<_i937.LocalLicenseDataSource>()),
    );
    gh.lazySingleton<_i591.DeleteUserUseCase>(
      () => _i591.DeleteUserUseCase(gh<_i462.UserRepository>()),
    );
    gh.lazySingleton<_i315.CreateUserUseCase>(
      () => _i315.CreateUserUseCase(gh<_i462.UserRepository>()),
    );
    gh.lazySingleton<_i307.GetRandomQuestionsUseCase>(
      () => _i307.GetRandomQuestionsUseCase(
        questionRepository: gh<_i359.QuestionRepository>(),
        questionCategoryRepository: gh<_i764.QuestionCategoryRepository>(),
      ),
    );
    gh.lazySingleton<_i591.LearningBloc>(
      () => _i591.LearningBloc(
        getAllQuestionCategoriesUseCase:
            gh<_i106.GetAllQuestionCategoriesUseCase>(),
        getQuestionCategoriesByIdUseCase:
            gh<_i106.GetQuestionCategoriesByIdUseCase>(),
        getQuestionCategoriesByLicenseUseCase:
            gh<_i106.GetQuestionCategoriesByLicenseUseCase>(),
        getRandomQuestionsUseCase: gh<_i106.GetRandomQuestionsUseCase>(),
        getQuestionsByCategoryUseCase:
            gh<_i106.WatchQuestionsByCategoryUseCase>(),
        updateQuestionStatusUseCase: gh<_i106.UpdateQuestionStatusUseCase>(),
      ),
    );
    gh.factory<_i172.UserBloc>(
      () => _i172.UserBloc(
        createUserUseCase: gh<_i315.CreateUserUseCase>(),
        deleteUserUseCase: gh<_i591.DeleteUserUseCase>(),
      ),
    );
    gh.lazySingleton<_i896.GetLicenseByIdUseCase>(
      () => _i896.GetLicenseByIdUseCase(gh<_i182.LicenseRepository>()),
    );
    gh.lazySingleton<_i48.GetLicensesUseCase>(
      () => _i48.GetLicensesUseCase(gh<_i182.LicenseRepository>()),
    );
    gh.lazySingleton<_i867.WatchCurrentUserUseCase>(
      () => _i867.WatchCurrentUserUseCase(gh<_i245.UserRepository>()),
    );
    gh.factory<_i704.LicenseBloc>(
      () => _i704.LicenseBloc(gh<_i743.GetLicensesUseCase>()),
    );
    gh.lazySingleton<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        watchCurrentUserUseCase: gh<_i743.WatchCurrentUserUseCase>(),
        deleteUserUseCase: gh<_i743.DeleteUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
