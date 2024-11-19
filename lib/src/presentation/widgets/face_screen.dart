import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'dart:async';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:image_picker/image_picker.dart';





// //face recognition
// void _validateFaceDetectionOfAdmin({
//   bool isCheckOut = true,
// }) async {
//   _user.image == ""
//       ? mfImageReal = MatchFacesImage(
//       (await rootBundle.load(ImagePaths.myProfile)).buffer.asUint8List(),
//       ImageType.PRINTED)
//       : mfImageReal = MatchFacesImage(
//     //convert user profile url to unit8List
//     // image.toByteData().buffer.asUInt8List()
//     (await NetworkAssetBundle(Uri.parse(_user.image)).load(_user.image))
//         .buffer
//         .asUint8List(),
//     ImageType.LIVE,
//   );
//
//   if (mfImageReal == null) {
//     showMessageDialogWidget(
//       context: context,
//       text: S.of(context).faceNotFound,
//       icon: ImagePaths.icCancelNew,
//       buttonText: S.of(context).ok,
//       onTap: () {
//         Navigator.of(context).pop();
//       },
//     );
//     return;
//   }
//   _bloc.add(MatchFacesImageEvent(
//     mfImageReal: mfImageReal,
//     isCheckout: isCheckOut,
//   ));
// }
//
// void _matchFace(MatchFacesImage currentImage, bool isCheckOut) async {
//   bool cameraPermission = await PermissionServiceHandler()
//       .handleServicePermission(setting: Permission.camera);
//   if (cameraPermission) {
//     String similarityStatus = "failed";
//     await faceSdk.startFaceCapture().then((value) async {
//       showLoading();
//       var image = value.image;
//       if (image != null) {
//         var takenImage = MatchFacesImage(image.image, value.image!.imageType);
//         var request = MatchFacesRequest([takenImage, currentImage]);
//         var response = await faceSdk.matchFaces(request);
//         var split = await faceSdk.splitComparedFaces(response.results, 0.7);
//         var match = split.matchedFaces;
//         if (match.isNotEmpty) {
//           similarityStatus =
//           "${(match[0].similarity * 100).toStringAsFixed(2)}%";
//         }
//       }
//     }).then((value) {
//       if (similarityStatus == "failed") {
//         hideLoading();
//         showMessageDialogWidget(
//             context: context,
//             text: S.of(context).faceMatchFailed,
//             icon: ImagePaths.icCancelNew,
//             buttonText: S.of(context).ok,
//             onTap: () {
//               Navigator.pop(context);
//             });
//       } else {
//         print("similarity: $similarityStatus");
//         if (isCheckOut) {
//           _bloc.add(CheckOutEvent());
//         } else {
//           _bloc.add(CheckInEvent());
//         }
//       }
//     });
//   } else {
//     await showActionDialogWidget(
//         context: context,
//         text: S.current.youShouldHaveCameraPermission,
//         icon: ImagePaths.profile,
//         primaryText: S.current.yes,
//         secondaryText: S.current.no,
//         primaryAction: () async {
//           Navigator.pop(context);
//           openAppSettings();
//         },
//         secondaryAction: () {
//           Navigator.pop(context);
//         });
//   }
// }
//
// // If 'assets/regula.license' exists, init using license(enables offline match)
// // otherwise init without license.
//
// //for download sdk from this website
// //https://support.regulaforensics.com/hc/en-us/articles/115004219343-Regula-Downloads-Manager
// void initialize() async {
//   var license = await loadAssetIfExists("assets/regula.license");
//   InitConfig? config;
//   if (license != null) config = InitConfig(license);
//   var (success, error) = await faceSdk.initialize(config: config);
// }
//
// Future<ByteData?> loadAssetIfExists(String path) async {
//   try {
//     return await rootBundle.load(path);
//   } catch (_) {
//     return null;
//   }
// }





class FaceScreen extends BaseStatefulWidget {
  const FaceScreen({super.key});

  @override
  _FaceScreenState baseCreateState() => _FaceScreenState();
}

class _FaceScreenState extends BaseState<FaceScreen> {
  var faceSdk = FaceSDK.instance;

  var _status = "nil";
  var _similarityStatus = "nil";
  var _livenessStatus = "nil";
  List<Image> imagesDB = [
    Image.asset('assets/images/ic_profile_place_holder.png'),
    Image.asset('assets/images/ic_profile_place_holder.png'),
  ]; // = <Image>
  var _uiImage = Image.asset('assets/images/ic_profile_place_holder.png');

  set status(String val) => setState(() => _status = val);

  set similarityStatus(String val) => setState(() => _similarityStatus = val);

  set livenessStatus(String val) => setState(() => _livenessStatus = val);

  set uiImages(List<Image> val) => setState(() => imagesDB = val);

  set uiImage(Image val) => setState(() => _uiImage = val);
  List<MatchFacesImage?> mfImages = [];

  // MatchFacesImage? mfImage1;
  // MatchFacesImage? mfImage2;
  MatchFacesImage? mfImageSimilarity;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    init();
  }

  void init() async {
    super.initState();
    // mfImage1 = MatchFacesImage(
    //     (await  loadAssetIfExists("assets/images/ic_profile_place_holder.png"))!.buffer.asUint8List(), ImageType.PRINTED
    // );

    if (!await initialize()) return;
    status = "Ready";
  }

  void startLiveness() async {
    var result = await faceSdk.startLiveness(
      config: LivenessConfig(skipStep: [LivenessSkipStep.ONBOARDING_STEP]),
      notificationCompletion: (notification) {
        print(notification.status);
      },
    );
    if (result.image == null) return;
    setImage(result.image!, ImageType.LIVE, 1);
    livenessStatus = result.liveness.name.toLowerCase();
  }

  void matchFaces() async {
    if (mfImages.isEmpty || mfImageSimilarity == null) {
      setState(() {
        status = "Both images required!";
      });
      return;
    }
    setState(() {
      status = "Processing...";
    });
    double highestSimilarity = 0;
    bool isFinished = false;
    for (var image in mfImages) {
      if (mfImages.indexOf(image) == mfImages.length - 1) {
        isFinished = true;
      }
      var request = MatchFacesRequest([image!, mfImageSimilarity!]);
      try {
        var response = await faceSdk.matchFaces(request);
        var split = await faceSdk.splitComparedFaces(response.results, 0.7);
        var match = split.matchedFaces;

        if (match.isNotEmpty && highestSimilarity < match[0].similarity) {
          highestSimilarity = match[0].similarity;
          similarityStatus = "${(highestSimilarity * 100).toStringAsFixed(2)}%";
        }
      } catch (e) {
        print("Error matching faces: $e");
      }
    }
    if (isFinished) {
      status = "Ready";
     if(highestSimilarity==0){
       similarityStatus = "failed";
     }
      setState(() {});
    }
  }

  clearResults() {
    status = "Ready";
    similarityStatus = "nil";
    livenessStatus = "nil";
    imagesDB = [
      Image.asset('assets/images/ic_profile_place_holder.png'),
      Image.asset('assets/images/ic_profile_place_holder.png'),
    ];
    mfImageSimilarity = null;
    mfImages.clear();
    setState(() {});
  }

  // If 'assets/regula.license' exists, init using license(enables offline match)
  // otherwise init without license.
  Future<bool> initialize() async {
    status = "Initializing...";
    var license = await loadAssetIfExists("assets/regula.license");
    InitConfig? config;
    if (license != null) config = InitConfig(license);
    var (success, error) = await faceSdk.initialize(config: config);
    if (!success) {
      status = error!.message;
      print("${error.code}: ${error.message}");
    }
    return success;
  }

  Future<ByteData?> loadAssetIfExists(String path) async {
    try {
      return await rootBundle.load(path);
    } catch (_) {
      return null;
    }
  }

  setImage(Uint8List bytes, ImageType type, int number) {
    similarityStatus = "nil";
    var mfImage = MatchFacesImage(bytes, type);
    if (number == 1) {
      mfImages.add(mfImage);
      imagesDB[0] = Image.memory(bytes);
      livenessStatus = "nil";
    }
    if (number == 2) {
      mfImages.add(mfImage);
      imagesDB[1] = Image.memory(bytes);
    }
    if (number == 3) {
      mfImageSimilarity = mfImage;
      uiImage = Image.memory(bytes);
    }
    print(mfImages.length);
  }

  Widget useGallery(int number) {
    return textButton("Use gallery", () async {
      Navigator.pop(context);
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setImage(File(image.path).readAsBytesSync(), ImageType.PRINTED, number);
      }
    });
  }

  Widget useCamera(int number) {
    return textButton("Use camera", () async {
      Navigator.pop(context);
      var response = await faceSdk.startFaceCapture();
      var image = response.image;
      if (image != null) setImage(image.image, image.imageType, number);
    });
  }

  Widget image(Image image, Function() onTap) => GestureDetector(
        onTap: onTap,
        child: Image(height: 150, width: 150, image: image.image),
      );

  Widget button(String text, Function() onPressed) {
    return SizedBox(
      width: 250,
      child: textButton(text, onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
          )),
    );
  }

  Widget text(String text) => Text(text, style: const TextStyle(fontSize: 18));

  Widget textButton(String text, Function() onPressed, {ButtonStyle? style}) =>
      TextButton(
        onPressed: onPressed,
        style: style,
        child: Text(text),
      );

  setImageDialog(BuildContext context, int number) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Select option"),
          actions: [useGallery(number), useCamera(number)],
        ),
      );

  @override
  Widget baseBuild(BuildContext bc) {
    if (_status == "Processing...") showLoading();
    if (_status == "Ready") hideLoading();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(_status))),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(bc).size.height / 8),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text("Fill the Database below to get started"),
              const SizedBox(
                height: 15,
              ),
              image(imagesDB[0], () => setImageDialog(bc, 1)),
              image(imagesDB[1], () => setImageDialog(bc, 2)),
              const SizedBox(
                height: 15,
              ),
              text("Select image to match"),
              const SizedBox(
                height: 15,
              ),
              image(_uiImage, () => setImageDialog(bc, 3)),
              Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 15)),
              button("Match", () => matchFaces()),
              button("Liveness", () => startLiveness()),
              button("Clear", () => clearResults()),
              Container(margin: const EdgeInsets.fromLTRB(0, 15, 0, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("Similarity: $_similarityStatus"),
                  Container(margin: const EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  text("Liveness: $_livenessStatus")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
//build.gradle

// aaptOptions {
// noCompress "Regula/faceSdkResource.dat"
// }


//face recognition
// void _validateFaceDetectionOfAdmin({
//   bool isCheckOut = true,
// }) async {
//   _user.image == ""
//       ? mfImageReal = MatchFacesImage(
//       (await rootBundle.load(ImagePaths.myProfile)).buffer.asUint8List(),
//       ImageType.PRINTED)
//       : mfImageReal = MatchFacesImage(
//     //convert user profile url to unit8List
//     // image.toByteData().buffer.asUInt8List()
//     (await NetworkAssetBundle(Uri.parse(_user.image)).load(_user.image))
//         .buffer
//         .asUint8List(),
//     ImageType.LIVE,
//   );
//
//   if (mfImageReal == null) {
//     showMessageDialogWidget(
//       context: context,
//       text: S.of(context).faceNotFound,
//       icon: ImagePaths.icCancelNew,
//       buttonText: S.of(context).ok,
//       onTap: () {
//         Navigator.of(context).pop();
//       },
//     );
//     return;
//   }
//   _bloc.add(MatchFacesImageEvent(
//     mfImageReal: mfImageReal,
//     isCheckout: isCheckOut,
//   ));
// }
//
// void _matchFace(MatchFacesImage currentImage, bool isCheckOut) async {
//   bool cameraPermission = await PermissionServiceHandler()
//       .handleServicePermission(setting: Permission.camera);
//   if (cameraPermission) {
//     String similarityStatus = "failed";
//     await faceSdk.startFaceCapture().then((value) async {
//       showLoading();
//       var image = value.image;
//       if (image != null) {
//         var takenImage = MatchFacesImage(image.image, value.image!.imageType);
//         var request = MatchFacesRequest([takenImage, currentImage]);
//         var response = await faceSdk.matchFaces(request);
//         var split = await faceSdk.splitComparedFaces(response.results, 0.7);
//         var match = split.matchedFaces;
//         if (match.isNotEmpty) {
//           similarityStatus =
//           "${(match[0].similarity * 100).toStringAsFixed(2)}%";
//         }
//       }
//     }).then((value) {
//       if (similarityStatus == "failed") {
//         hideLoading();
//         showMessageDialogWidget(
//             context: context,
//             text: S.of(context).faceMatchFailed,
//             icon: ImagePaths.icCancelNew,
//             buttonText: S.of(context).ok,
//             onTap: () {
//               Navigator.pop(context);
//             });
//       } else {
//         print("similarity: $similarityStatus");
//         if (isCheckOut) {
//           _bloc.add(CheckOutEvent());
//         } else {
//           _bloc.add(CheckInEvent());
//         }
//       }
//     });
//   } else {
//     await showActionDialogWidget(
//         context: context,
//         text: S.current.youShouldHaveCameraPermission,
//         icon: ImagePaths.profile,
//         primaryText: S.current.yes,
//         secondaryText: S.current.no,
//         primaryAction: () async {
//           Navigator.pop(context);
//           openAppSettings();
//         },
//         secondaryAction: () {
//           Navigator.pop(context);
//         });
//   }
// }
//
// // If 'assets/regula.license' exists, init using license(enables offline match)
// // otherwise init without license.
//
// //for download sdk from this website
// //https://support.regulaforensics.com/hc/en-us/articles/115004219343-Regula-Downloads-Manager
// void initialize() async {
//   var license = await loadAssetIfExists("assets/regula.license");
//   InitConfig? config;
//   if (license != null) config = InitConfig(license);
//   var (success, error) = await faceSdk.initialize(config: config);
// }
//
// Future<ByteData?> loadAssetIfExists(String path) async {
//   try {
//     return await rootBundle.load(path);
//   } catch (_) {
//     return null;
//   }
// }