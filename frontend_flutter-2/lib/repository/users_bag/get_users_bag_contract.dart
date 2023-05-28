import '../../models/Item.dart';
import '../../models/UserItem.dart';

abstract class UsersBagRepository{
  Future<List<Item>> getAllItem(String gender);
   Future<List<UsersItem>> getUsersItem();
}