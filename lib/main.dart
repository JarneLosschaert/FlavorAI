import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/ScannerScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Main(camera: camera),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.camera});

  final CameraDescription camera;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  late ScannerScreen _scannerScreen;

  @override
  void initState() {
    super.initState();
    _scannerScreen = ScannerScreen(camera: widget.camera);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomeScreen(),
      Builder(
        builder: (context) => _scannerScreen, // Use a Builder here
      ),
      Container(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(32),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: HomeScreenCard(
                text: "Recipes",
                subText: "You have saved 0 recipes",
                backgroundColor: Colors.grey
              ),
          ),
          Flexible(
            flex: 1,
            child: HomeScreenCard(
                text: "Refrigerator",
                backgroundColor: Colors.grey
              ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child:
                      AspectRatio(aspectRatio: 1, child: HomeScreenCard(
                        text: "3 free scans", backgroundColor: Color.fromARGB(255, 66, 66, 66),
                      )),
                ),
                Expanded(
                  child:
                      AspectRatio(aspectRatio: 1, child: HomeScreenCard(
                        text: "Buy Premium", backgroundColor: Color.fromARGB(255, 66, 66, 66),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  final String text;
  final String? subText;
  final Color backgroundColor;

  const HomeScreenCard(
      {
        super.key,
        required this.text,
        this.subText,
        required this.backgroundColor,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (subText != null)
              Text(
                subText!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
