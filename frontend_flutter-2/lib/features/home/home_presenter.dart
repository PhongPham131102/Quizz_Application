import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/home/home_contract.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/repository/home/get_home_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';

class HomePresenter {
  HomeContract _view;
  late HomeRepository _repository;
  HomePresenter(this._view) {
    _repository = Injector().HomeRepository;
  }
  getinfo() async {
    _view.setIsLoading(true);
    _view.updateProfile(await _repository.getProfile());
    _view.setIsLoading(false);
  }

  getsocket() {
    IO.Socket socket =
        IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    print(uid);
    socket.on("profile$uid", (data) {
      _view.updateProfile(Profile.fromJson(data['profile']));
    });
  }
}
