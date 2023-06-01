import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/models/Item.dart';
import 'package:frontend_flutter/models/Profile.dart';

import '../../repository/detail_item/get_detail_item_contract.dart';
import 'detail_item_contract.dart';

class DetailItemPresenter {
  DetailItemContract _view;
  late DetailItemRepository _repository;
  DetailItemPresenter(this._view) {
    _repository = Injector().DetailItemRepository;
  }
  BuyItem(Item item, Profile userProfile, int quantity) async {
    if (item.typeMoney == "gold") {
      if (userProfile.gold >= quantity * item.price) {
        _view.setIsloading(true);
        bool isBuy = await _repository.buyItem(item.id, quantity,item.typeMoney,quantity * item.price);
        _view.setIsloading(false);
        if (isBuy) {
          _view.showMessage("Mua vật phẩm thành công!", true, true);
        } else {
          _view.showMessage("Vật phẩm này đang có lỗi!", true, false);
        }
      } else {
        _view.showMessage("Không đủ vàng!", false, false);
      }
    } else {
      if (userProfile.diamond >= quantity * item.price) {
        _view.setIsloading(true);
      bool isBuy = await _repository.buyItem(item.id, quantity,item.typeMoney,quantity * item.price);
        _view.setIsloading(false);
        if (isBuy) {
          _view.showMessage("Mua vật phẩm thành công!", true, true);
        } else {
          _view.showMessage("Vật phẩm này đang có lỗi!", true, false);
        }
      } else {
        _view.showMessage("Không đủ kim cương hãy nạp thêm!", false, false);
      }
    }
  }
}
