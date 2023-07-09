import '../../models/Test.dart';

abstract class HomeContract{
    SetListTest(List<Test> tests);
    SetIsLoading(bool _isloading);
}