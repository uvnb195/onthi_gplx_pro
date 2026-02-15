import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:onthi_gplx_pro/core/usecase/usecase.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/usecases/index.dart';

part 'license_event.dart';
part 'license_state.dart';

@injectable
class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final GetLicensesUseCase _getLicensesUseCase;
  LicenseBloc(this._getLicensesUseCase) : super(LicenseInitial()) {
    on<LoadLicenses>(_onLoadLicenses);
    on<SelectLicense>(_onSelectLicense);
  }

  void _onLoadLicenses(LoadLicenses event, Emitter<LicenseState> emit) async {
    emit(LicenseLoading());

    final result = await _getLicensesUseCase(NoParams());

    result.fold(
      ifLeft: (failure) => emit(LicenseLoadFail(failure.message)),
      ifRight: (success) => emit(LicenseLoaded(licenses: success)),
    );
  }

  void _onSelectLicense(SelectLicense event, Emitter<LicenseState> emit) {
    if (state is LicenseLoaded) {
      emit((state as LicenseLoaded).copyWith(selectedLicense: event.selected));
    }
  }
}
