import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
// Initialise a controller. It will contains signature points, stroke width and pen color.
// It will allow you to interact with the widget
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );
  Signature? _signatureCanvas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // INITIALIZE. RESULT IS A WIDGET, SO IT CAN BE DIRECTLY USED IN BUILD METHOD
    _signatureCanvas = Signature(
      controller: _controller,
      width: 300,
      height: 300,
      backgroundColor: Colors.lightBlueAccent,
    );

// CLEAR CANVAS
    _controller.clear();

// EXPORT BYTES AS PNG
// The exported image will be limited to the drawn area
    _controller.toPngBytes();

// isEmpty/isNotEmpty CAN BE USED TO CHECK IF SIGNATURE HAS BEEN PROVIDED
    _controller.isNotEmpty; //true if signature has been provided
    _controller.isEmpty; //true if signature has NOT been provided
// EXPORT POINTS (2D POINTS ROUGHLY REPRESENTING WHAT IS VISIBLE ON CANVAS)
    var exportedPoints = _controller.points;
    //EXPORTED POINTS CAN BE USED TO INITIALIZE PREVIOUS CONTROLLER
    final SignatureController _anotherController =
        SignatureController(points: exportedPoints);
  }

//DONT FORGET TO DISPOSE IT IN THE `dispose()` METHOD OF STATEFUL WIDGETS
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature'),
      ),
      body: _signatureCanvas,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data =
        await _controller.toPngBytes(height: 1000, width: 1000);
    if (data == null) {
      return;
    }

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('PNG Image'),
          ),
          body: Center(
            child: Container(
              color: Colors.grey[300],
              child: Image.memory(data),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> exportSVG(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarSVG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final SvgPicture data = _controller.toSVG()!;

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('SVG Image'),
          ),
          body: Center(
            child: Container(
              color: Colors.grey[300],
              child: data,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature Demo'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 300,
            child: Center(
              child: Text('Big container to test scrolling issues'),
            ),
          ),
          //SIGNATURE CANVAS
          Signature(
            key: const Key('signature'),
            controller: _controller,
            height: 300,
            backgroundColor: Colors.grey[300]!,
          ),
          //OK AND CLEAR BUTTONS

          const SizedBox(
            height: 300,
            child: Center(
              child: Text('Big container to test scrolling issues'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //SHOW EXPORTED IMAGE IN NEW ROUTE
              IconButton(
                key: const Key('exportPNG'),
                icon: const Icon(Icons.image),
                color: Colors.blue,
                onPressed: () => exportImage(context),
                tooltip: 'Export Image',
              ),
              IconButton(
                key: const Key('exportSVG'),
                icon: const Icon(Icons.share),
                color: Colors.blue,
                onPressed: () => exportSVG(context),
                tooltip: 'Export SVG',
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.undo());
                },
                tooltip: 'Undo',
              ),
              IconButton(
                icon: const Icon(Icons.redo),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.redo());
                },
                tooltip: 'Redo',
              ),
              //CLEAR CANVAS
              IconButton(
                key: const Key('clear'),
                icon: const Icon(Icons.clear),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.clear());
                },
                tooltip: 'Clear',
              ),
              // STOP Edit
              IconButton(
                key: const Key('stop'),
                icon: Icon(
                  _controller.disabled ? Icons.pause : Icons.play_arrow,
                ),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.disabled = !_controller.disabled);
                },
                tooltip: _controller.disabled ? 'Pause' : 'Play',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
