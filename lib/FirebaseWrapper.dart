import 'package:firebase_core/firebase_core.dart';

class FirebaseWrapper {

  static Future<FirebaseApp> iniciar() {
    return Firebase.initializeApp(
      options: FirebaseOptions(
        appId: '1:267651834878:android:64e691a1cc37d7788c16af',
        apiKey: 'AIzaSyBPIXcyWZ59v__OCvAZ1HTn3ZREZ-idKgo ',
        messagingSenderId: '267651834878',
        projectId: 'animedb-f17a8',
        databaseURL: 'https://animedb-f17a8-default-rtdb.europe-west1.firebasedatabase.app/',
      ));
  }
}