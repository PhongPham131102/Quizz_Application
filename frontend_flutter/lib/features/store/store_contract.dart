import '../../models/Item.dart';
import '../../models/UserItem.dart';

abstract class StoreContract {
  setListItems(List<Item> _items);
  setItemFilter(List<Item> _itemsfilter);
  setUserItems(List<UsersItem>  _usersitemlist);
  setType(String _type);
  setListType(List<String> _types);
  setDetailType(String _detailType);
  setListDetailType(List<String> _detailTypes);
  setUserIdItems(List<String> _UsersidItems);
  setselectedItem(String _selectedItem);
  setselectedindex(int _selectedindex);
  String gettypesSelectedIndex();
  setisloading(bool _isloading);
}
