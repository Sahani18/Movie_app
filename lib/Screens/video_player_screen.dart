import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String id;

  const VideoPlayer({Key key, this.id}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  TextEditingController _idController;
  TextEditingController _seekToController;

  YoutubePlayerController controller = YoutubePlayerController();

  youtubeVideoPlayerController() {
    String video = widget.id;

    controller = YoutubePlayerController(
      initialVideoId: video,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  @override
  void initState() {
    super.initState();

    this.youtubeVideoPlayerController();

    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
        child: YoutubePlayer(
          controller: controller,
          progressIndicatorColor: Colors.pink.shade900,
          aspectRatio: 16 / 9,
          bufferIndicator: CircularProgressIndicator(),
          showVideoProgressIndicator: true,
          liveUIColor: Colors.red.shade900,
          controlsTimeOut: Duration(seconds: 2),
          topActions: [],
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
            ),
            RemainingDuration(),
            PlaybackSpeedButton(),
            FullScreenButton(),
          ],
          onReady: () {
            controller.addListener(listener);
          },
        ),
      ),
    ));
  }

  void listener() async {
    bool _initialLoad;
    if (controller.value.isReady && _initialLoad) {
      _initialLoad = false;
      if (controller.flags.autoPlay) controller.play();
      if (controller.flags.mute) controller.mute();

      // widget.onReady?.call();
      if (controller.flags.controlsVisibleAtStart) {
        controller.updateValue(
          controller.value.copyWith(isControlsVisible: true),
        );
      }
    }
    if (mounted) setState(() {});
  }
}
