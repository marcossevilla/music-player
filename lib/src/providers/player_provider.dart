import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  /* props */
  // is the song playing right now
  bool _isPlaying = false;

  bool get isPlaying => this._isPlaying;

  set isPlaying(bool value) {
    this._isPlaying = value;
    notifyListeners();
  }

  // total song duration
  Duration _songDuration = Duration(milliseconds: 0);

  Duration get songDuration => this._songDuration;

  String get songDurationStr => this.printDuration(this._songDuration);

  set songDuration(Duration value) {
    this._songDuration = value;
    notifyListeners();
  }

  // specific time the song is in
  Duration _currentSongTime = Duration(milliseconds: 0);

  Duration get currentSongTime => this._currentSongTime;

  String get currentSongTimeStr => this.printDuration(this._currentSongTime);

  set currentSongTime(Duration value) {
    this._currentSongTime = value;
    notifyListeners();
  }

  AnimationController _controller;

  AnimationController get controller => this._controller;

  set controller(AnimationController value) {
    this._controller = value;
  }

  // song duration percentage
  double get percentage => this._songDuration.inSeconds > 0
      ? this._currentSongTime.inSeconds / this._songDuration.inSeconds
      : 0;

  // print song's total duration
  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
