import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_kit/x_kit.dart';

class PreviewMapWidget extends StatefulWidget {
  const PreviewMapWidget({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  final ShippingAddress shippingAddress;

  @override
  State<PreviewMapWidget> createState() => _PreviewMapWidgetState();
}

class _PreviewMapWidgetState extends State<PreviewMapWidget> {
  late CameraPosition initialCameraPosition;
  late Map<MarkerId, Marker> markers;
  var currentLocationIcon = BitmapDescriptor.defaultMarker;

  final _controller = Completer<GoogleMapController>();

  void setSourceAndDestinationIcons() async {
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/ios_map_pin480.png', 120);
    currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
    setState(() {});
  }

  void initialLocation() async {
    final latLng = LatLng(
      widget.shippingAddress.latitude!,
      widget.shippingAddress.longitude!,
    );
    initialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 17.8,
      tilt: 10.0,
    );
  }

  @override
  void initState() {
    setSourceAndDestinationIcons();
    initialLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: GoogleMap(
        markers: {
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(
              widget.shippingAddress.latitude!,
              widget.shippingAddress.longitude!,
            ),
            icon: currentLocationIcon,
          ),
        },
        myLocationButtonEnabled: false,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        },
      ),
    );
  }
}
