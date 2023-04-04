import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testwebhook/receiver.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'WebSocket Demo by Hilyathul Wahid'),
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
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://13.215.167.196:8082'));

  StreamController<String> streamController = StreamController.broadcast();

  String choice = '';

  void send(data) {
    channel.sink.add(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: choice == ''
            ? ChoiceMethod(context)
            : choice == 'Receiver'
                ? Receiver(channel: channel)
                : Column(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => send('UP'),
                              child: const ButtonWidget(
                                  color: Colors.blue,
                                  borderRadius: 10,
                                  textColor: Colors.white,
                                  width: 100,
                                  height: 50,
                                  text: 'UP'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () => send('LEFT'),
                                    child: const ButtonWidget(
                                        color: Colors.blue,
                                        borderRadius: 10,
                                        textColor: Colors.white,
                                        width: 100,
                                        height: 50,
                                        text: 'Left'),
                                  ),
                                  InkWell(
                                    onTap: () => send('RIGHT'),
                                    child: const ButtonWidget(
                                        color: Colors.blue,
                                        borderRadius: 10,
                                        textColor: Colors.white,
                                        width: 100,
                                        height: 50,
                                        text: 'Right'),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => send('DOWN'),
                              child: const ButtonWidget(
                                  color: Colors.blue,
                                  borderRadius: 10,
                                  textColor: Colors.white,
                                  width: 100,
                                  height: 50,
                                  text: 'Down'),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column ChoiceMethod(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              choice = 'Sender';
            });
          },
          child: ButtonWidget(
              color: Colors.blue,
              borderRadius: 20,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              text: 'Sender'),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
        InkWell(
          onTap: () {
            setState(() {
              choice = 'Receiver';
            });
          },
          child: ButtonWidget(
              color: Colors.blue,
              borderRadius: 20,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              text: 'Receiver'),
        )
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.color,
    required this.borderRadius,
    required this.textColor,
    required this.width,
    required this.height,
    required this.text,
  }) : super(key: key);

  final MaterialColor color;
  final double borderRadius;
  final Color textColor;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
