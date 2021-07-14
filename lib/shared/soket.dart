import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class SoketGet {
  var channel =
      IOWebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));

  listenSoket() {
    channel.stream.listen((massage) {
      print('massage$massage');
    });
  }

  addSoket(String massageCome) {
    channel.sink.add(massageCome);
  }

  closeSoket() {
    channel.sink.close(status.goingAway);
  }
}
