import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ValueNotifier<double> _valueNotifier;
  double counter = 0;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0);
  }

  void incrementCounter() {
    setState(() {
      if (counter < 33) {
        counter++;
        _valueNotifier.value = (counter / 33) * 100;
      }
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
      _valueNotifier.value = 0;
    });
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasbih Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 119, 210, 145),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 119, 210, 145),
        appBar: AppBar(
          title: const Text(
            'Tasbih Digital',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 119, 210, 145),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hitungan Tasbih',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${counter.toInt()} / 33',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SimpleCircularProgressBar(
                    size: 260,
                    progressColors: [Colors.amberAccent.shade400],
                    progressStrokeWidth: 18,
                    backStrokeWidth: 10,
                    mergeMode: true,
                    maxValue: 100,
                    animationDuration: 0,
                    valueNotifier: _valueNotifier,
                    onGetText: (value) {
                      return Text(
                        '${(value / 100 * 33).round()}',
                        style: const TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: incrementCounter,
                        child: const SizedBox(
                          width: 130,
                          height: 110,
                          child: Icon(
                            Icons.fingerprint,
                            size: 85,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tekan untuk menghitung',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: resetCounter,
          tooltip: 'Reset hitungan',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}