import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:video_player/video_player.dart';

import '../services/api_service.dart';

class PlayVid extends StatefulWidget {
  PlayVid({Key? key, required this.urlVideo, required this.nameVideo, required this.idVideo}) : super(key: key);
  String idVideo;
  String urlVideo;
  String nameVideo;

  @override
  _PlayVidState createState() => _PlayVidState(urlVideo, nameVideo, idVideo);
}

class _PlayVidState extends State<PlayVid> {
  late VideoPlayerController _controller;
  String urlVideo;
  String nameVideo;
  String idVideo;

  _PlayVidState(this.urlVideo, this.nameVideo, this.idVideo);

  String _videoDuration(Duration duration) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(urlVideo)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 220,
                                    child: Text(
                                      nameVideo,
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  settingButton(idVideo);
                                },
                                icon: Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                child: VideoPlayer(_controller),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _controller,
                                  builder:
                                      (context, VideoPlayerValue value, child) {
                                    return Text(
                                      _videoDuration(value.position),
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                    );
                                  }),
                              Expanded(
                                  child: SizedBox(
                                height: 20,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                ),
                              )),
                              Text(
                                _videoDuration(_controller.value.duration),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Copy url : ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: 200,
                                  child: SelectableText('${urlVideo}',
                                      style: TextStyle(fontSize: 18)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
  void settingButton(String idVideo) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 70,
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    APIService().deleteAlbum(idVideo).then((response) {
                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Success!",
                          "Success delete file!",
                          "OK",
                              () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/album', (route) => false);
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Error!",
                          "Failed delete file! Please try again",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Delete'), Icon(Icons.delete)],
                  )),
            ],
          ),
        ));
  }
}
