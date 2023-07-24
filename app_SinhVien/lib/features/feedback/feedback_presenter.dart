import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/feedback/feedback_contract.dart';
import 'package:frontend_flutter/repository/feedback/get_feedback_contract.dart';

class FeedBackPresenter {
  // ignore: unused_field
  FeedBackContract _view;
  // ignore: unused_field
  late FeedBackRepository _repository;
  FeedBackPresenter(this._view) {
    _repository = Injector().FeedBackRepository;
  }
  CheckContent(String content) async {
    if (content == "") {
      _view.SetInformationError();
    }
    await _repository.SendFeedBack(content);
    _view.SetInformationSuccess();
  }
}
