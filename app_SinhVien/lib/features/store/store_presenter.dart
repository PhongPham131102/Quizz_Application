import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/store/store_contract.dart';
import 'package:frontend_flutter/models/Item.dart';
import 'package:frontend_flutter/models/UserItem.dart';
import 'package:frontend_flutter/repository/store/get_store_contract.dart';

class StorePresenter {
  StoreContract _view;
  late StoreRepository _repository;
  StorePresenter(this._view) {
    _repository = Injector().StoreRepository;
  }
  GetAllItem(String gender) async {
    _view.setisloading(true);
    List<Item> items = await _repository.getAllItem(gender);
    _view.setListItems(items);
    List<UsersItem> usersitemlist = await _repository.getUsersItem();
    _view.setUserItems(usersitemlist);
    List<String> UsersidItems = [];
    for (var usersItem in usersitemlist) {
      UsersidItems.add(usersItem.idItem);
    }
    _view.setUserIdItems(UsersidItems);
    _view.setListType(items.map((item) => item.type).toSet().toList());
    _view.setListDetailType(items
        .where((item) => item.type == _view.gettypesSelectedIndex())
        .map((item) => item.detailType)
        .toSet()
        .toList());
    _view.setType(_view.gettypesSelectedIndex());
    _view.setItemFilter(
        items.where((a) => a.type == _view.gettypesSelectedIndex()).toList());
    _view.setisloading(false);
  }
}
