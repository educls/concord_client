import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:concord_client/entities/Channels_server.dart';
import 'package:concord_client/entities/Message.dart';
import 'package:concord_client/entities/User_server_online.dart';
import 'package:concord_client/entities/Users_on_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:get/get.dart';

import 'channel_controller.dart';
import 'chat_controller.dart';
import 'server_controller.dart';
import 'user_controller.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketController extends GetxController {
  late UserController instUser = Get.find();
  late ServerController instServer = Get.find();
  late ChatController instChat = Get.find();
  late ChannelController instChannel = Get.find();
  WebSocketChannel? _channel;

  final RxBool _isRecording = false.obs;
  Timer? _sendAudioTimer;
  final FlutterAudioCapture _audioCapture = new FlutterAudioCapture();

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    // initializeAudioCapture();
  }

  Future<void> initializeAudioCapture() async {
    await _audioCapture.init();
  }

  @override
  void onClose() {
    _channel?.sink.close(status.goingAway);
    _audioCapture.stop();
    _sendAudioTimer?.cancel();
    super.onClose();
  }

  void connect() async {
    final wsUrl = 'ws://localhost:8383/ws/connect?userToken=${jsonDecode(instUser.token)}&serverToken=${instServer.serverToken.value}';
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _channel!.stream.listen(
      (message) {
        final data = jsonDecode(message);

        if (data['event'] == 'audioData') {
          print(data.user);
          String base64Audio = data['audio'];
          Uint8List audioBytes = base64Decode(base64Audio);
          _audioPlayer.play(BytesSource(audioBytes));
        }

        if (data['event'] == 'updateListUsers') {
          instServer.getUsersServer();
        }

        if (data['event'] == 'usersOnChannel') {
          List<UsersOnChannel> users = usersOnChannelFromJson(jsonEncode(data['usersOnChannel']));
          for (var user in users) {
            bool userExists = instChannel.channelsServer.isNotEmpty && instChannel.channelsServer.first.usersConected!.any((userToCheck) => userToCheck.userId == user.id);

            if (!userExists) {
              instChannel.setNewUserOnChannel(0, UsersConected(userId: user.id, username: user.username));
              instServer.usersServer.refresh();
            }
          }
        }

        if (data['event'] == 'disconnectOnChannel') {
          instChannel.removeUserOnChannel(data['index'], data['user_id']);
        }

        if (data['event'] == 'clientsOnline') {
          final usersOnlineJson = jsonEncode(data['usersOnline']);
          instServer.usersOnline.value = userServerOnlineFromJson(usersOnlineJson);
          print('Usuários online atualizados: ${instServer.usersOnline}');
        }

        if (data['event'] == 'getMessageEvent') {
          print('Mensagem recebida: $message');
          instChat.setNewMessage(messageWebSocketFromJson(message));
          instChat.scrollController.animateTo(
            instChat.scrollController.position.maxScrollExtent + 100.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      onDone: () {
        print('Conexão WebSocket fechada');
      },
      onError: (error) {
        print('Erro no WebSocket: $error');
      },
    );
    print('Conectado ao WebSocket');
  }

  Future<void> startBroadcasting(String channelId) async {
    _isRecording.value = true;

    await _audioCapture.start((dataAudio) {
      _sendAudioTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
        if (_isRecording.value) {
          var uint8List = Uint8List.fromList(
            dataAudio.buffer.asInt8List(dataAudio.offsetInBytes, dataAudio.lengthInBytes),
          );
          _channel!.sink.add(jsonEncode({'audioData': 'audioData', 'channel_id': channelId, 'audio': base64Encode(uint8List), 'user_id': instUser.user.value.id}));
        } else {
          timer.cancel();
        }
      });
    }, (onError) {
      print(onError);
    }, sampleRate: 16000, bufferSize: 3000);
  }

  Future<void> stopBroadcasting() async {
    _isRecording.value = false;

    _audioCapture.stop();
    _sendAudioTimer?.cancel();
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }

  void sendMessage(String message) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'text': message}));
    }
  }

  void connectOnChannel(String channelId, int index) async {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'connectOnChannel': 'connectOnChannel', 'channel_id': channelId, 'index': index}));
      await startBroadcasting(channelId);
    }
  }

  void disconnectOnChannel(String channelId, int index) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'disconnectOnChannel': 'disconnectOnChannel', 'channel_id': channelId, 'index': index, 'user_id': instUser.user.value.id}));
      stopBroadcasting();
    }
  }

  void getUsersOnChannel(String channelId, int index) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'getUsersOnChannel': 'getUsersOnChannel', 'channel_id': channelId, 'index': index}));
    }
  }

  void updateUsers() {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'updateListUsers': 'updateListUsers'}));
    }
  }
}
