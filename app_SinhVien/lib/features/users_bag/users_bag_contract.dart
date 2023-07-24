import '../../models/Item.dart';
import '../../models/UserItem.dart';

abstract class UsersBagContract {
  setListItems(List<Item> _items);
  setItemFilter(List<Item> _itemsfilter);
  setUserItems(List<UsersItem> _usersitemlist);
  setType(String _type);
  setListType(List<String> _types);
  setDetailType(String _detailType);
  setListDetailType(List<String> _detailTypes);
  setUserIdItems(List<String> _UsersidItems);
  setselectedItem(String _selectedItem);
  setselectedindex(int _selectedindex);
  String gettypesSelectedIndex();
  setisloading(bool _isloading);
  setischange(bool _ischange);
  bool isUsing(Item item);
  String getPerformance(Item item);
  changeClothes(String type, String value);
}
