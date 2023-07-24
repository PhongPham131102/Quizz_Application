import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/pick_character/pick_character_contract.dart';
import 'package:frontend_flutter/repository/pick_character/get_pick_character_contract.dart';

class PickCharacterPresenter {
  PickCharacterContract _view;
  late PickCharacterRepository _repository;
  PickCharacterPresenter(this._view) {
    _repository = Injector().PickCharacterRepository;
  }
  PickMale() {
    _view.setselectedGender(0);
  }

  PickFemale() {
    _view.setselectedGender(1);
  }

  SetCharacter(String token, int selectedGender) async {
    _view.setIsLoading(true);
    bool isUpdated = await _repository.updateGender(
        token, selectedGender == 0 ? "male" : "female");
    _view.setIsLoading(false);
    if (isUpdated) {
    _view.pushSetNameScreen();
    } else {
     _view.showDialog("Lỗi Sever vui lòng thử lại sau.");
    }
  }
}
