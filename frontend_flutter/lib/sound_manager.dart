import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class GlobalSoundManager {
  static final GlobalSoundManager _instance = GlobalSoundManager._internal();

  factory GlobalSoundManager() {
    return _instance;
  }
  List<String> battle = [
    "sounds/battle.m4a",
    "sounds/battle1.m4a",
    "sounds/battle2.m4a",
  ];
  List<String> battletraining = [
    "sounds/battletraining.m4a",
    "sounds/battletraining1.m4a",
    "sounds/battletraining2.mp3",
    "sounds/battletraining3.m4a",
  ];
  List<String> button = [
    "sounds/button.m4a",
    "sounds/button1.mp3",
    "sounds/button2.mp3",
    "sounds/button3.mp3",
    "sounds/button4.wav",
    "sounds/button5.mp3",
    "sounds/button6.mp3",
    "sounds/button7.wav",
  ];
  List<String> complete = [
    "sounds/complete.wav",
    "sounds/complete1.wav",
    "sounds/complete2.wav",
  ];

  List<String> correct = [
    "sounds/correct.wav",
    "sounds/correct1.wav",
  ];
  List<String> findrival = [
    "sounds/findrival1.mp3",
    "sounds/find_rival.m4a",
    "sounds/fingrival2.mp3",
  ];
  List<String> home = [
    "sounds/home.m4a",
    "sounds/home1.m4a",
    "sounds/home2.mp3",
    "sounds/home3.mp3",
  ];
  List<String> loser = [
    "sounds/loser.m4a",
  ];
  List<String> success = [
    "sounds/success.mp3",
  ];
  List<String> summary = [
    "sounds/summary.mp3",
    "sounds/summary1.mp3",
  ];
  List<String> winner = [
    "sounds/winner.m4a",
    "sounds/winner1.m4a",
    "sounds/winner2.m4a",
  ];
  List<String> wrong = ["wrong1.mp3"];
  GlobalSoundManager._internal();
  Future<bool> get shouldPlayBackgroundMusic async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('shouldPlayBackgroundMusic') ?? true;
  }

  Future<void> setShouldPlayBackgroundMusic(bool shouldPlay) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('shouldPlayBackgroundMusic', shouldPlay);
    playBackgroundMusic("home");
  }

  AudioPlayer backgroundMusicPlayer = AudioPlayer();
  Future<void> playBackgroundMusic(String type) async {
    backgroundMusicPlayer.setVolume(0.5);
    bool _shouldPlayBackgroundMusic = await shouldPlayBackgroundMusic;
    if (_shouldPlayBackgroundMusic) {
      Random random = Random();
      await backgroundMusicPlayer.stop();

      String musicUrl = "";
      if (type == "home") {
        musicUrl = home[random.nextInt(home.length)];
      }
      if (type == "battle") {
        musicUrl = battle[random.nextInt(battle.length)];
      }
      if (type == "findrival") {
        musicUrl = findrival[random.nextInt(findrival.length)];
      }
      if (type == "battletraining") {
        musicUrl = battletraining[random.nextInt(battletraining.length)];
      }
      await backgroundMusicPlayer.play(AssetSource(musicUrl));
      await backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await backgroundMusicPlayer.resume();
    } else {
      await backgroundMusicPlayer.stop();
    }
  }

  Future<void> playButton(String type) async {
    bool _shouldPlayBackgroundMusic = await shouldPlayBackgroundMusic;
    if (_shouldPlayBackgroundMusic) {
      AudioPlayer ButtonPlayer = AudioPlayer();
      ButtonPlayer.setVolume(1.0);
      String musicUrl = "";
      if (type == "button") {
        musicUrl = "sounds/button7.wav";
      }
      if (type == "star") {
        musicUrl = "sounds/button.m4a";
      }
      if (type == "countdown") {
        musicUrl = "sounds/countdown.m4a";
      }
      if (type == "summary1") {
        musicUrl = "sounds/summary1.mp3";
      }
      if (type == "correct") {
        musicUrl = "sounds/correct1.wav";
      }
      if (type == "wrong") {
        musicUrl = "sounds/wrong1.mp3";
      }
      if (type == "winner") {
        musicUrl = "sounds/winner.m4a";
      }
      if (type == "winner2") {
        musicUrl = "sounds/winner2.m4a";
      }
      if (type == "loser") {
        musicUrl = "sounds/loser.m4a";
      }
      if (type == "lightning") {
        ButtonPlayer.setVolume(0.8);
        musicUrl = "sounds/lightning.m4a";
      }

      await ButtonPlayer.play(AssetSource(musicUrl));
    }
  }
}
