import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:arama_app/services/cloud_firebase.dart';
import 'package:arama_app/widgets/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:arama_app/platform_channel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // static const MethodChannel telephonyChannel = MethodChannel('com.example/telephony');
  //static const callStatusChannel = EventChannel('call_status_channel');
  //final EventChannel eventChannel = EventChannel('phone_number_channel');
  String callStatus = 'Bilinmiyor';
  String phoneNumber = 'No call';
  int? state;
  final FireStoreServices firestore = FireStoreServices();
  late Stream<List<Map<String, dynamic>>> userDataStream;
  int selectedStatus = 1;

  @override
  void initState() {
    super.initState();
    userDataStream = firestore.veriOkuRealTime(); // Stream'i başlat

    getPermission().then((value) {
      if (value) {
        PlatformChannel().callStream().listen((event) {
          var arr = event.split("-");
          phoneNumber = arr[0];
          state = int.tryParse(arr[1]);
          String callStatus = arr[2];

          setState(() {
            if (callStatus == 'Arama Bitti' ||
                callStatus == 'Cevaplandı' ||
                callStatus == 'Arama Başladı') {
              callStatus = 'Arama Durumu: $callStatus';
              print('$callStatus');
            } else {
              //phoneNumber = 'Telefon Numarası: $phoneNumber';
              print('Telefon Numarası: $phoneNumber, Durum: $state, Çağrı Durumu: $callStatus');
            }
          });
        });
      }
    });
  }

  Future<bool> getPermission() async {
    if (await Permission.phone.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.phone.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _checkAndStartAutomaticCall(List<Map<String, dynamic>> userList) {
    for (Map<String, dynamic> user in userList) {
      bool direkAra = user['direkara'];

      if (direkAra) {
        // Otomatik arama fonksiyonunu çağır
        _startAutomaticCall(user['mobilenumber']);

        user['direkara'] = false; // buraya bak işe yarıyor mu ?.

        firestore.updateUserDirectCallStatus(user['mobilenumber']);
        break; // İlk bulduğu kişiyi aradıktan sonra döngüden çık
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Hoşgeldiniz Selim Sarıkaya'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: userDataStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    print('${snapshot.error}');
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> userList = snapshot.data!;
                    if (userList.isNotEmpty) {
                      _checkAndStartAutomaticCall(userList);

                      return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Her bir kullanıcı verisini ListTile olarak göster
                          return ListTileUser(userList, index);
                        },
                      );
                    } else {
                      return const Center(child: Text('Veri bulunamadı.'));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dismissible ListTileUser(List<Map<String, dynamic>> userList, int index) {
    return Dismissible(
      key: Key(userList[index]['mobilenumber']),
      onDismissed: (direction) {
        // ListTile'ı silme işlemi gerçekleştiğinde yapılacak işlemler
        setState(() {
          firestore.deleteUser(userList[index]['mobilenumber']);
          userList.removeAt(index);
        });
      },
      background: const Row(
        children: [Icon(Icons.delete), Text('Aramayı sil')],
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  userList[index]['name'].substring(0, 1),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              title: Text('${userList[index]['name']} ${userList[index]['surname']}'),
              subtitle: Text(userList[index]['mobilenumber']),
              onTap: () async {
                // Burada kullanıcıyı arama veya başka bir işlem yapabilirsiniz
                await FlutterPhoneDirectCaller.callNumber(
                  userList[index]['mobilenumber'],
                );
                _checkAndUpdateCallStatus(userList[index]['mobilenumber']);
              },
              trailing: const Icon(Icons.phone),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showMyDialog(context); // _showMyDialog fonksiyonunu doğrudan çağırın
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.zero, // Yumuşaklığı kaldırmak için sıfır kullanın
                      ),
                    ),
                    child: const Row(
                      children: [
                        const Icon(Icons.menu),
                        SizedBox(width: 8), // İkon ile metin arasında bir boşluk bırakmak için
                        Text('Sonuç'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMyDialog(BuildContext context) {
    int selectedStatus = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialogAlert(
          onChanged: (value) {
            selectedStatus = value;
            print('Secilen status = $selectedStatus');
          },
        );
      },
    );
  }

  _startAutomaticCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  void _checkAndUpdateCallStatus(String phoneNumber) async {
    if (callStatus == "Arama Bitti") {
      await firestore.updateUserCallStatus(phoneNumber);
    } else {
      // Her 1 saniyede bir durumu kontrol et
      Timer.periodic(Duration(seconds: 1), (Timer timer) async {
        if (callStatus == "Arama Bitti") {
          await firestore.updateUserCallStatus(phoneNumber);
          timer.cancel(); // Durumu bulduğumuzda Timer'ı durdur
        }
      });
    }
  }
}
