import 'package:flutter/material.dart';
import 'package:torrent_streamer/torrent_streamer.dart';

class TorrentStreamerView extends StatefulWidget {
  final String url;
  TorrentStreamerView({Key? key, required this.url}) : super(key: key);
  @override
  _TorrentStreamerViewState createState() => _TorrentStreamerViewState();
}

class _TorrentStreamerViewState extends State<TorrentStreamerView> {
  bool isStreamReady = false;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    _addTorrentListeners();
  }

  void _addTorrentListeners() {
    TorrentStreamer.addEventListener('progress', (data) {
      setState(() => progress = data['progress']);
    });

    TorrentStreamer.addEventListener('ready', (_) {
      setState(() => isStreamReady = true);
    });
  }

  Future<void> _startDownload() async {
    await TorrentStreamer.start('torrent-link-here');
  }

  Future<void> _openVideo(BuildContext context) async {
    if (progress == 100) {
      await TorrentStreamer.launchVideo();
    } else {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text('Are You Sure?'),
                content: new Text(
                    'Playing video while it is still downloading is experimental and only works on limited set of apps.'),
                actions: <Widget>[
                  TextButton(
                      child: new Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: new Text("Yes, Proceed"),
                      onPressed: () async {
                        await TorrentStreamer.launchVideo();
                        Navigator.of(context).pop();
                      })
                ]);
          },
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: <Widget>[
              ElevatedButton(
                  child: Text('Start Download'), onPressed: _startDownload),
              Container(height: 8),
              ElevatedButton(
                  child: Text('Play Video'),
                  onPressed: () => _openVideo(context))
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max),
        padding: EdgeInsets.all(16));
  }
}
