import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/colors.dart';

/// Homepage
class TrailerWidget extends StatefulWidget {
  final String trailerCode;
  final bool isHome;
  final double? height;
  const TrailerWidget({
    Key? key,
    required this.trailerCode,
    this.isHome = false,
    this.height,
  }) : super(key: key);
  @override
  _TrailerWidgetState createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerCode,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: widget.isHome ? true : false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    if (widget.isHome) {
      if (!_isPlayerReady && !mounted && !_controller.value.isFullScreen) {
        setState(() {
          _playerState = _controller.value.playerState;
          _videoMetaData = _controller.metadata;
        });
      }
    } else {
      if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
        setState(() {
          _playerState = _controller.value.playerState;
          _videoMetaData = _controller.metadata;
        });
      }
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isFullScreen = false;
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        // isFullScreen = false;
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight,
        // ]);
      },
      onExitFullScreen: () {
        /// The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        // isFullScreen = true;
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight,
        // ]);
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio:
            // isFullScreen == true ? 10 / 9 : 16 / 9,
            // :
            widget.height ?? 16 / 9,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: mainColor,
          handleColor: Colors.grey,
        ),
        progressIndicatorColor: mainColor,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          // setState(() {

          // });
          _isPlayerReady = true;
        },
        onEnded: (data) {
          // _controller.load(
          //     widget.trailerCode[(widget.trailerCode.indexOf(data.videoId))]);
          // _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Center(child: player),
    );
  }
}
