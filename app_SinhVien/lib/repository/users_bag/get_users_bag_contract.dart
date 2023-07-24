import '../../models/Item.dart';
import '../../models/UserItem.dart';

abstract class UsersBagRepository{
  Future<List<Item>> getAllItemOfUser(String gender);
   Future<List<UsersItem>> getUsersItem();
   Future<bool> changeClothes(String type,String value);
}