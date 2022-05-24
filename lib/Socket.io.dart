import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late IO.Socket socket ;

  @override
  void initState() {

    print("hello");
    super.initState();
    socket = IO.io('https://mcu.mizdah.com:9000?user_id=594&session_id=9350',<String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      listen();
      emit();
      // socket.emit('msg', 'test');
    });
    print("hello");
  }

  void listen() {
    socket.on('event', (data) {
      print(data);
    } );
  }

  void emit() {
    socket.emitWithAck("get-room", {"room_id": "meeting_3107"}, ack: (result)
        {
          print(result);
        });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: Container(),
    );
  }
}