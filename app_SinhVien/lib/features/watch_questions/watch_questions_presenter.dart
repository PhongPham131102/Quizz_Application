import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/watch_questions/watch_questions_contract.dart';
import 'package:frontend_flutter/repository/watch_questions/get_watch_questions_contract.dart';

class WatchQuestionsPresenter {
  // ignore: unused_field
  WatchQuestionsContract _view;
  // ignore: unused_field
  late WatchQuestionsRepository _repository;
  WatchQuestionsPresenter(this._view) {
    _repository = Injector().WatchQuestionsRepository;
  }
}
