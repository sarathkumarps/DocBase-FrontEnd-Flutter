import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('wss://echo.websocket.org/');
  @override
  _ChatScreenState createState() => _ChatScreenState(channel: channel);
}

class _ChatScreenState extends State<ChatScreen> {
  final inputController = TextEditingController();
  final List<String> messageList = [];
  final WebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();

  _ChatScreenState({this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Doctor Chat (Online) ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                            labelText: 'Send a message',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ))),
                  ),
                ],
              ),
              Expanded(child: getMessageList())
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            if (inputController.text.isNotEmpty) {
              print(inputController.text);
              channel.sink.add(inputController.text); // Adding text
              setState(() {
                messageList.add(inputController.text);
              });

              inputController.text = '';
            }
          },
        ),
      ),
    );
  }

  @override
  ListView getMessageList() {
    //For Looping
    List<Widget> listWidget = [];
    for (String message in messageList) {
      listWidget.add(
        ListTile(
          leading: Icon(Icons.chat_rounded),
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                message, //printing list contains userchat and  doctor reply(websocket)
                style: TextStyle(fontSize: 20),
              ),
            ),
            color: Colors.cyan[100],
          ),
        ),
      );
    }
    return ListView(
      children: listWidget,
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
