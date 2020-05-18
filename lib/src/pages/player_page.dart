import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height * 0.72,
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: ListWheelScrollView(
        itemExtent: 40.0,
        diameterRatio: 1.5,
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

class DiscTitle extends StatelessWidget {
  const DiscTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
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
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.play_arrow),
            onPressed: () {},
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
    return Container(
      child: Column(
        children: [
          // total song duration text
          Text('2:50'),
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
                  height: 80.0,
                  width: 2.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          // current song time text
          Text('1:06'),
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
            Image.asset('assets/saturation.jpg'),
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
