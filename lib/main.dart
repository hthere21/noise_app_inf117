import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  double _dBaValue = 0.0; // Initialize dBA value to 0.0

  @override
  void initState() {
    super.initState();
    _startRecording();
  }

  void _startRecording() async {
    // await audioPlayer.start();
    audioPlayer.onDurationChanged.listen((duration) {
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        _calculateDBA();
        setState(() {}); 
      });
    });
  }

  void _calculateDBA() {
    _dBaValue = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'dBA Value:',
            ),
            Text(
              _dBaValue
                  .toStringAsFixed(2), // Display dBA with 2 decimal places.
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          audioPlayer.stop(); // Stop audio recording.
        },
        tooltip: 'Stop Recording',
        child: const Icon(Icons.stop),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Dispose of the audio player when done.
    super.dispose();
  }
}
