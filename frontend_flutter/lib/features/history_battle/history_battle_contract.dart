import '../../models/Match.dart';

abstract class HistoryBattleContract{
  setIsLoading(bool _isloading);
  setListMatches(List<MatchBattle> _matches);
}