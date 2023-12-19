import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });


 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 late VideoPlayerController _controller;

 double videoSpeed = 0;

 List speed = [
  {'value': 0, 'speed': 1.0},
  {'value': 1, 'speed': 1.5},
  {'value': 0, 'speed': 2.0},
 ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
       '/assets/video2.mp4' ))
        //'https://kino.super.kg/movies/2022-08/3953.mp4'
      ..initialize().then((_) {
        
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Colors.blue[400],
       
        title: const Text('Video Player App', style: TextStyle(color: Colors.white, fontSize: 26,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
     body: Center(
        child: _controller.value.isInitialized
            ? Stack(alignment: Alignment.center, children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds -10));
                          });
                        },
                        color: Colors.white,
                        iconSize: 35,
                        icon: const Icon(Icons.replay_10)),
                    IconButton(
                        onPressed: () { 
                          setState(() {
                            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();  
                          });         
                    
        },
        color: Colors.white,
        iconSize: 30,
        icon:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds +10));
                          });
                        },
                        color: Colors.white,
                        iconSize: 35,
                        icon: const Icon(Icons.forward_10)),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                  children: [
                   PopupMenuButton(
                        icon: const Icon(Icons.slow_motion_video,
                            color: Colors.white, size: 30),
                            color: Colors.black54,
                        itemBuilder: (context) => speed.map(
                          (e) => PopupMenuItem<int>(
                            onTap: () {
                              videoSpeed = e['value'].toDouble();
                              setState(() {
                                switch (e[speed]) {
                                  case 0 : _controller.setPlaybackSpeed(1.0);
                                  break;
                                  case 1: _controller.setPlaybackSpeed(1.5);
                                  break;
                                  case 2: _controller.setPlaybackSpeed(2.0);
                                  break;
                                  default: _controller.setPlaybackSpeed(1.0);

                                }                                
                              });
                            },
                            value: e['value'],
                            child: ListTile(title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(e['speed'].toString(), style: const TextStyle(color: Colors.white,
                              fontSize: 20),),
                              videoSpeed == e['value']
                              ? Icon(Icons.check, color: Colors.blue,)
                              : Icon(null),
                            ]),),
                            //  Text(e['speed'].toString(),
                            // style: TextStyle(color: Colors.white),),
                          ),
                        )
                        .toList(),
                      ),
                      SizedBox(width: 10),
                  ],
                )),
                Padding(padding: EdgeInsets.only(top: 180),
                child: SizedBox(width: double.infinity, 
                child: VideoProgressIndicator(_controller,
                allowScrubbing: true,
                colors: VideoProgressColors(backgroundColor: Colors.white,
                bufferedColor: Colors.yellow,
                playedColor: Colors.red),),), ),
              ])
            : Container(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child:
      //       Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      // ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}