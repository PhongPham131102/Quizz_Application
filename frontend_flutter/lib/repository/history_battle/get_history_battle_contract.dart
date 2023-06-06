import '../../models/Match.dart';
abstract class HistoryBattleRepository{
     Future<List<MatchBattle>> getAllMatchs();
}