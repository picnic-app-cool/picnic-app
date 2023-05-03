import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';
import 'package:picnic_app/features/circles/domain/use_cases/ban_user_use_case.dart';

class BanUserPresenter extends Cubit<BanUserViewModel> {
  BanUserPresenter(
    BanUserPresentationModel model,
    this._banUserUseCase,
    this.navigator,
  ) : super(model);

  final BanUserNavigator navigator;
  final BanUserUseCase _banUserUseCase;

  // ignore: unused_element
  BanUserPresentationModel get _model => state as BanUserPresentationModel;

  void onTapConfirm() => _banUserUseCase.execute(userId: state.user.id, circleId: state.circleId).doOn(
        success: (_) => navigator.closeWithResult(true),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onTapClose() => navigator.close();

  void onTapChoice(BanType banType) => tryEmit(_model.copyWith(selectedBanType: banType));
}
