import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Artboard? _riveArtboard;
  RiveAnimationController? _controller;

  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    loadRiveFile();
  }

  Future<void> loadRiveFile() async {
    try {
      RiveFile.initialize();
      final data = await rootBundle.load('assets/anims/git_theme.riv');
      final file = RiveFile.import(data);

      if (file != null) {
        final artboard = file.mainArtboard;
        print('Artboard loaded: ${artboard.name}');

        artboard.addController(_controller = SimpleAnimation('to_dark'));
        setState(() => _riveArtboard = artboard);
      } else {
        print('Failed to load Rive file.');
      }
    } catch (e) {
      print('Error loading Rive file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.balooBhai2(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.settings,
                size: 144,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Version 1.0.0'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('About Us'),
            ),
            Divider(),
            Flexible(
              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard!),
              ),
            ),
            Switch(
              value: _isDarkTheme,
              onChanged: (val) {
                setState(() {
                  _isDarkTheme = val;
                });
                if (_isDarkTheme) {
                  Get.changeTheme(ThemeData.dark());
                  _riveArtboard?.removeController(_controller!);
                  _riveArtboard?.addController(
                      _controller = SimpleAnimation('to_light'));
                } else {
                  Get.changeTheme(ThemeData.light());
                  _riveArtboard?.removeController(_controller!);
                  _riveArtboard?.addController(
                      _controller = SimpleAnimation('to_dark'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
