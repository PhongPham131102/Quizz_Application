import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/users_bag/users_bag_contract.dart';
import 'package:frontend_flutter/repository/users_bag/get_users_bag_contract.dart';

import '../../models/Item.dart';
import '../../models/UserItem.dart';

class UsersBagPresenter {
  UsersBagContract _view;
  late UsersBagRepository _repository;
  UsersBagPresenter(this._view) {
    _repository = Injector().UsersBagRepository;
  }
  GetAllItem(String gender) async {
    _view.setisloading(true);

    List<UsersItem> usersitemlist = await _repository.getUsersItem();
    List<Item> items = await _repository.getAllItemOfUser(gender);
    List<String> UsersidItems = [];
    for (var usersItem in usersitemlist) {
      UsersidItems.add(usersItem.idItem);
    }
    List<Item> filteredItems =
        items.where((item) => UsersidItems.contains(item.id)).toList();
    _view.setUserItems(usersitemlist);
    _view.setListItems(filteredItems);

    _view.setUserIdItems(UsersidItems);
    _view.setListType(filteredItems.map((item) => item.type).toSet().toList());
    _view.setListDetailType(filteredItems
        .where((item) => item.type == _view.gettypesSelectedIndex())
        .map((item) => item.detailType)
        .toSet()
        .toList());
    _view.setType(_view.gettypesSelectedIndex());
    _view.setItemFilter(filteredItems
        .where((a) => a.type == _view.gettypesSelectedIndex())
        .toList());
    _view.setisloading(false);
  }

  changeClothes(Item item) async {
    if (item.detailType == "Áo") {
      _view.setischange(true);
      bool hasChange = await _repository.changeClothes("Áo", item.shortName);
      _view.setischange(false);
      if (hasChange) {
        _view.changeClothes("Áo", item.shortName);
      }
    } else if (item.detailType == "Quần") {
      _view.setischange(true);
      bool hasChange = await _repository.changeClothes("Quần", item.shortName);
      _view.setischange(false);
      if (hasChange) {
        _view.changeClothes("Quần", item.shortName);
      }
    } else if (item.detailType == "Váy") {
      _view.setischange(true);
      bool hasChange = await _repository.changeClothes("Váy", item.shortName);
      _view.setischange(false);
      if (hasChange) {
        _view.changeClothes("Váy", item.shortName);
      }
    } else if (item.detailType == "Giày") {
      _view.setischange(true);
      bool hasChange = await _repository.changeClothes("Giày", item.shortName);
      _view.setischange(false);
      if (hasChange) {
        _view.changeClothes("Giày", item.shortName);
      }
    } else if (item.detailType == "Cặp") {
      _view.setischange(true);
      bool hasChange = await _repository.changeClothes("Cặp", item.shortName);
      _view.setischange(false);
      if (hasChange) {
        _view.changeClothes("Cặp", item.shortName);
      }
    }
  }
}
