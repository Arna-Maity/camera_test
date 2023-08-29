import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter-eLinux 3.13.1 Camera Demo',
      home: CamFeedView(),
    );
  }
}

class CamFeedView extends StatefulWidget {
  const CamFeedView({Key? key}) : super(key: key);

  @override
  State<CamFeedView> createState() => _CamFeedViewState();
}

class _CamFeedViewState extends State<CamFeedView> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    startCamera();

    isCameraReady = false;
  }

  void startCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);

    try {
      /* _cameraValue = */ await controller.initialize();

      if (!mounted) {
        return;
      }
      setState(() {
        isCameraReady = true;
      });
    } on CameraException catch (e) {
      debugPrint("CameraException occured!");
      debugPrint("Error Code: ${e.code}");
      debugPrint("Error Code: ${e.description}");
      switch (e.code) {
        case 'CameraAccessDenied':
          // Handle access errors here.
          break;
        default:
          // Handle other errors here.
          break;
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: CameraPreview(controller),
    );
  }
}
