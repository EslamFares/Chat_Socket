import 'package:chat_soket/shared/soket.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

List<String> chat = ['aa'];
TextEditingController textEditingController = TextEditingController();
SoketGet soketGet = SoketGet();

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    SoketGet().listenSoket();
    super.initState();
  }

  @override
  void dispose() {
    SoketGet().closeSoket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: soketGet.channel.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    massegeBody(
                      width: width,
                      text: textEditingController.text.isNotEmpty
                          ? textEditingController.text
                          : snapshot.hasData
                              ? 'sended ✔️✔️'
                              : 'no data',
                    ),
                    snapshot.hasData
                        ? massegeBody(
                            width: width,
                            text: snapshot.hasData
                                ? snapshot.data.toString()
                                : 'no data',
                            send: false)
                        : Container(),
                  ],
                );
              },
            )
                // ListView.builder(
                //   itemCount: chat.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return massegeBody(width, chat[index]);
                //   },
                // ),
                ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: 'Your Message'),
                )),
                IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        soketGet.addSoket(textEditingController.text);
                      }
                      textEditingController.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget massegeBody(
      {required double width, required String text, bool send = true}) {
    return Container(
      margin: EdgeInsets.only(
          left: send ? width * .5 : 0, right: send ? 0 : width * .5, top: 10),
      width: width * .5,
      height: 50,
      decoration: BoxDecoration(
        color: send ? Colors.blue : Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 25),
      )),
    );
  }
}
