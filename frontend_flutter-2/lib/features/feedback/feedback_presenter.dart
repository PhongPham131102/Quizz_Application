import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/feedback/feedback_contract.dart';
import 'package:frontend_flutter/repository/feedback/get_feedback_contract.dart';

class FeedBackPresenter{
  FeedBackContract _view;
  late FeedBackRepository _repository;
  FeedBackPresenter(this._view)
  {
    _repository=Injector().FeedBackRepository;
  }
}