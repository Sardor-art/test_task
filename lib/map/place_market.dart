import 'dart:math';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapMarkers extends StatelessWidget {
  const MapMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MapMarker();
  }
}

class _MapMarker extends StatefulWidget {
  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<_MapMarker> {
  final List<MapObject> mapObjects = [];
  final List<Point> lineList = [];
  YandexMapController? _controller;
  int countId = 0;
  bool _routes = false;
  Point? _start;
  Point? _end;
  List<DrivingSessionResult> _results = [];
  DrivingSession? _sessions;
  bool _progress = false;
  Location location = Location();

  @override
  void dispose() {
    super.dispose();

    _close();
  }

  void findMyLocation({bool isFind = false}) async {
    if (isFind) {
      await getLocation(null);
    }
    await _controller!.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: Point(
              longitude: location.longitude!, latitude: location.latitude!),
          zoom: 20,
        )),
        animation: MapAnimation(type: MapAnimationType.linear));
  }

  Future<void> getLocation(Point? value, {bool isFirst = false}) async {
    location = await BackgroundLocation().getCurrentLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yandex map',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          /* IconButton(
            onPressed: () async {
              findMyLocation(isFind: true);
            },
            icon: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),*/
          IconButton(
            onPressed: () {
              setState(() {
                _routes = !_routes;
                _start = null;
                _end = null;
                mapObjects.clear();
              });
            },
            icon: Icon(
              Icons.call_split_rounded,
              color: _routes ? Colors.green : Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: YandexMap(
                onMapCreated: ((YandexMapController controller) async {
                  setState(() {
                    _controller = controller;
                  });
                }),
                mapObjects: mapObjects,
                onMapTap: (point) {
                  if (_routes) {
                    if (_start == null) {
                      _start = point;
                    } else {
                      if (_end == null) {
                        _end = point;
                        _requestRoutes();
                      } else {
                        return;
                      }
                    }
                  }
                  countId++;
                  lineList.add(point);
                  final placemark = Placemark(
                    mapId: MapObjectId(
                        'normal_icon_placemark ' + countId.toString()),
                    point: point,
                    onTap: (Placemark self, Point point) =>
                        print('Tapped me at $point'),
                    opacity: 0.7,
                    direction: 90,
                    isDraggable: true,
                    onDragStart: (_) => print('Drag start'),
                    onDrag: (_, Point point) => print('Drag at point $point'),
                    onDragEnd: (_) => print('Drag end'),
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image:
                            BitmapDescriptor.fromAssetImage('assets/place.png'),
                      ),
                    ),
                  );
                  if (lineList.length > 1 && _start == null) {
                    final polyline = Polyline(
                      mapId: MapObjectId('polyline' + countId.toString()),
                      coordinates: lineList,
                      strokeColor: Colors.black,
                      strokeWidth: 2,
                      // default value 5.0, this will be a little bold
                      outlineColor: Colors.yellow[200]!,
                      outlineWidth: 2.0,
                      onTap: (Polyline self, Point point) =>
                          print('Tapped me at $point'),
                    );
                    setState(() {
                      mapObjects.add(polyline);
                    });
                  }
                  setState(() {
                    mapObjects.add(placemark);
                  });
                },
              ),
            ),
          ),
          if (_routes)
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                  child: Text(
                    _start == null
                        ? 'Choose start point'
                        : _end == null
                            ? 'Choose end point'
                            : 'Ready your route',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )),
          if (_progress)
            const Align(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mapObjects.clear();
            lineList.clear();
            _start = null;
            _end = null;
          });
        },
        tooltip: 'Clear',
        child: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }

  Future<void> _requestRoutes() async {
    // print('Points: ${startPlacemark.point},${stopByPlacemark.point},${endPlacemark.point}');
    setState(() {
      _progress = true;
    });
    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: _start!, requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: _end!, requestPointType: RequestPointType.wayPoint),
          // RequestPoint(point: endPlacemark.point, requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));
    _init(resultWithSession.result);
    _sessions = resultWithSession.session;
  }

  List<Widget> _getList() {
    final list = <Widget>[];

    if (_results.isEmpty) {
      list.add((Text('Nothing found')));
    }

    for (var r in _results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(
            Text('Route $i: ${route.metadata.weight.timeWithTraffic.text}'));
      });

      list.add(Container(height: 20));
    }

    return list;
  }

  Future<void> _cancel() async {
    await _sessions!.cancel();

    setState(() {
      _progress = false;
    });
  }

  Future<void> _close() async {
    await _sessions!.close();
  }

  Future<void> _init(Future<DrivingSessionResult> result) async {
    await _handleResult(await result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(() {
      _results.add(result);
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(Polyline(
          mapId: MapObjectId('route_${i}_polyline'),
          coordinates: route.geometry,
          strokeColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
}
