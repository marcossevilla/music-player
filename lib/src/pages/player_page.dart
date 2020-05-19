import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:music_player_app/src/providers/player_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';
import '../widgets/custom_app_bar.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _Background(),
          Column(
            children: <Widget>[
              // gradient background
              // page app bar
              CustomAppBar(),
              // disc image and song duration
              _DiscInfo(),
              // song title and artist + play/pause button
              DiscTitle(),
              // song lyrics
              Expanded(child: Lyrics()),
            ],
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70.0)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [Color(0xff33333e), Color(0xff201e28)],
        ),
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();

    return Container(
      margin: EdgeInsets.only(top: 60, left: 15.0, right: 15.0),
      child: ListWheelScrollView(
        itemExtent: 40.0,
        diameterRatio: 1.5,
        physics: BouncingScrollPhysics(),
        children: [
          for (String verse in lyrics)
            Text(
              verse,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class _DiscInfo extends StatelessWidget {
  const _DiscInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DiscImage(),
          DiscProgressBar(),
        ],
      ),
    );
  }
}

class DiscTitle extends StatefulWidget {
  const DiscTitle({
    Key key,
  }) : super(key: key);

  @override
  _DiscTitleState createState() => _DiscTitleState();
}

class _DiscTitleState extends State<DiscTitle>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  bool _isFirstTime = true;
  AnimationController _controller;

  final audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  void open() {
    final provider = Provider.of<PlayerProvider>(context, listen: false);

    // open song
    audioPlayer.open(Audio('assets/rental-brockhampton.mp3'));

    // update current song time in real-time
    audioPlayer.currentPosition.listen((duration) {
      provider.currentSongTime = duration;
    });

    // assign the song's total duration
    audioPlayer.current.listen((playingAudio) {
      provider.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // song title and artist
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                'RENTAL',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline4,
              ),
              // artist
              Text(
                'BROCKHAMPTON',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
          // play button
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Theme.of(context).accentColor,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _controller,
            ),
            onPressed: () {
              final provider = Provider.of<PlayerProvider>(
                context,
                listen: false,
              );

              if (this._isPlaying) {
                _controller.reverse();
                this._isPlaying = false;
                provider.controller.stop();
              } else {
                _controller.forward();
                this._isPlaying = true;
                provider.controller.repeat();
              }

              if (_isFirstTime) {
                this.open();
                _isFirstTime = false;
              } else {
                audioPlayer.playOrPause();
              }
            },
          ),
        ],
      ),
    );
  }
}

class DiscProgressBar extends StatelessWidget {
  const DiscProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);
    final percentage = provider.percentage;

    return Container(
      child: Column(
        children: [
          // total song duration text
          Text(provider.songDurationStr),
          SizedBox(height: 15.0),
          Stack(
            children: [
              // back line of total time
              Container(
                height: 180.0,
                width: 2.0,
                color: Colors.white.withOpacity(0.1),
              ),
              // top line with current song part
              Positioned(
                bottom: 0,
                child: Container(
                  height: 180 * percentage,
                  width: 2.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          // current song time text
          Text(provider.currentSongTimeStr),
        ],
      ),
    );
  }
}

class DiscImage extends StatelessWidget {
  const DiscImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerProvider>(context);

    return Container(
      width: 250,
      height: 250,
      padding: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // actual album cover
            SpinPerfect(
              // passing exposed controller to provider
              animate: false,
              duration: Duration(seconds: 10),
              child: Image.asset('assets/saturation.jpg'),
              controller: (controller) => provider.controller = controller,
            ),
            // transparent bigger circle at the center
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            // dark smaller circle at the center
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ],
        ),
      ),
      // this decoration is for the transparent-gradient border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        gradient: LinearGradient(
          colors: const [Color(0xff484750), Color(0xff1e1c24)],
        ),
      ),
    );
  }
}
