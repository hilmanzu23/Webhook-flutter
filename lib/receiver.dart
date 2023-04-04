import 'package:flutter/material.dart';
import 'package:testwebhook/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Receiver extends StatelessWidget {
  const Receiver({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final WebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                    child: snapshot.data == 'UP'
                        ? Container(
                            child: const ButtonWidget(
                                color: Colors.blue,
                                borderRadius: 100,
                                textColor: Colors.white,
                                width: 50,
                                height: 50,
                                text: ''),
                          )
                        : Container()),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                          child: snapshot.data == 'LEFT'
                              ? Container(
                                  child: const ButtonWidget(
                                      color: Colors.blue,
                                      borderRadius: 100,
                                      textColor: Colors.white,
                                      width: 50,
                                      height: 50,
                                      text: ''),
                                )
                              : Container()),
                      Expanded(flex: 7, child: Container()),
                      Expanded(
                          child: snapshot.data == 'RIGHT'
                              ? Container(
                                  child: const ButtonWidget(
                                      color: Colors.blue,
                                      borderRadius: 100,
                                      textColor: Colors.white,
                                      width: 50,
                                      height: 50,
                                      text: ''),
                                )
                              : Container()),
                    ],
                  ),
                ),
                Expanded(
                    child: snapshot.data == 'DOWN'
                        ? Container(
                            child: const ButtonWidget(
                                color: Colors.blue,
                                borderRadius: 100,
                                textColor: Colors.white,
                                width: 50,
                                height: 50,
                                text: ''),
                          )
                        : Container()),
              ],
            );
          }
          return const Center(
            child: Text('No data'),
          );
        });
  }
}
