import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/index.dart';

part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final GetLicensesUseCase _getLicensesUseCase;
  LicenseBloc(this._getLicensesUseCase) : super(LicenseInitial()) {
    on<LoadLicenses>(_onLoadLicenses);
  }

  void _onLoadLicenses(LoadLicenses event, Emitter<LicenseState> emit) async {
    emit(LicenseLoading());

    await Future.delayed(const Duration(seconds: 10));

    final result = await _getLicensesUseCase(NoParams());

    result.fold(
      ifLeft: (failure) => emit(LicenseLoadFail(failure.message)),
      ifRight: (success) => emit(LicenseLoaded(licenses: success)),
    );
  }
}
