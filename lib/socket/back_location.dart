import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<Point>();

  void Function(Point) get addResponse => _socketResponse.sink.add;

  Stream<Point> get getResponse => _socketResponse.stream;

/* void dispose() {
    _socketResponse.close();
  }*/
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  Socket socket = io('http://localhost:3000',
      OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('event', (data) => streamSocket.addResponse);
  socket.onDisconnect((_) => print('disconnect'));
}

class BackLocation extends StatefulWidget {
  const BackLocation({Key? key}) : super(key: key);

  @override
  State<BackLocation> createState() => _BackLocationState();
}

class _BackLocationState extends State<BackLocation> {
  final List<Point> list = [];
  int time = 0;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      time++;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Background Location Service'),
        ),
        body: StreamBuilder<Point>(
            stream: streamSocket.getResponse,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                list.add(snapshot.data!);
              }
              print('11 ====');

              return Center(
                child: Column(
                  children: [
                    locationData('Latitude: ' +
                        (snapshot.data?.latitude ?? 'Waiting...').toString()),
                    locationData('Longitude: ' +
                        (snapshot.data?.latitude ?? 'Waiting...').toString()),
                    Expanded(
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            return Text('${index + 1}:  ${list[index]}');
                          }),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await BackgroundLocation.setAndroidNotification(
                              title: 'Background service is running',
                              message: 'Background location in progress',
                              icon: '@mipmap/ic_launcher',
                            );
                            await BackgroundLocation.startLocationService(
                              distanceFilter: 0,
                            );
                            /* await BackgroundLocation.setAndroidConfiguration(
                            30000,
                          );*/

                            BackgroundLocation.getLocationUpdates((location) {
                              print('===-= $time');
                              if (location.longitude != null &&
                                  (time == 30 || time == 1)) {
                                time = 1;
                                streamSocket.addResponse(
                                  Point(
                                      latitude: location.latitude!,
                                      longitude: location.longitude!),
                                );
                              }

                              /* time = DateTime.fromMillisecondsSinceEpoch(
                                    location.time!.toInt())
                                .toString();*/
                            });
                          } catch (e) {
                            print('===error===\n$e');
                          }
                        },
                        child: Text('Start Location Service')),
                    ElevatedButton(
                        onPressed: () {
                          BackgroundLocation.stopLocationService();
                        },
                        child: Text('Stop Location Service')),
                    ElevatedButton(
                        onPressed: () {
                          getCurrentLocation();
                        },
                        child: Text('Get Current Location')),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  void getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print('This is current Location ' + location.toMap().toString());
    });
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    _timer?.cancel();
    super.dispose();
  }
}
