import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gigachat_app_unofficial/screens/Chat.dart';
import 'package:gigachat_app_unofficial/screens/ChatList.dart';
import 'package:gigachat_app_unofficial/utils/MyHttpOverrides.dart';

MaterialColor black = const MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Colors.black,
    100: Colors.black,
    200: Colors.black,
    300: Colors.black,
    400: Colors.black,
    500: Colors.black,
    600: Colors.black,
    700: Colors.black,
    800: Colors.black,
    900: Colors.black,
  },
);

final light = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primarySwatch: black,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  iconTheme: const IconThemeData(color: Colors.black),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.black))),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.grey,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  primaryColor: Colors.grey,
  useMaterial3: true,
  backgroundColor: Colors.grey,
  cupertinoOverrideTheme:
      const NoDefaultCupertinoThemeData(primaryColor: Colors.black),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GigaChat',
      debugShowCheckedModeBanner: false,
      theme: light,
      home: const MyHomePage(title: 'GigaChat'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF219A38),
                pressedOpacity: 1,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChatList();
                      },
                    ),
                    (r) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(
                        "assets/icons/sber.png",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Continue with Sber ID",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
                pressedOpacity: 1,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChatList();
                      },
                    ),
                    (r) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: SvgPicture.asset(
                        "assets/icons/apple.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.lighten,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Continue with Apple",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                pressedOpacity: 1,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChatList();
                      },
                    ),
                    (r) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset("assets/icons/google.png"),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
