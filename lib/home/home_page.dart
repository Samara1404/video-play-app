import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });


 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://kino.super.kg/movies/2022-08/3953.mp4'))
      ..initialize().then((_) {
        
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: const Text('Video Player App'),
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
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 35,
                        icon: const Icon(Icons.replay_10)),
                    IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 35,
                        icon: const Icon(Icons.play_arrow)),
                    IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 35,
                        icon: const Icon(Icons.forward_10)),
                  ],
                )
              ])
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
