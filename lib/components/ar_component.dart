import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArComponent extends StatefulWidget {
  ArComponent({Key key}) : super(key: key);

  @override
  _ArComponentState createState() => _ArComponentState();
}

class _ArComponentState extends State<ArComponent> {
  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadSingleImage();
  }

  loadSingleImage() async {
    final ByteData bytes = await rootBundle.load('assets/manos/scan_earth.jpeg');
    arCoreController.loadSingleAugmentedImage(
      bytes: bytes.buffer.asUint8List(),
    );
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;
      _addSphere(augmentedImage);
    }
  }

  Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load('assets/manos/bien.png');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: augmentedImage.index / 2,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0.0, 0.0, 0.0),
    );
    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  }

  @override
  void initState() {
    super.initState();
    AnimatedConstants.xOffset = 0.0;
    AnimatedConstants.yOffset = 0.0;
    AnimatedConstants.scaleFactor = 1.0;
    AnimatedConstants.isDragged = false;
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }
}
