import 'package:flutter/material.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//final FlutterLocalNotificationsPlugin notificationsPlugin =
//    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      initialRoute: '/',
      routes: {
        '/': (context) => const CounterPage(title: 'Flutter Demo Home Page'),
        '/second': (context) => const SecondScreen(),
      },
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  late Future<String> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = _fetchGreeting();
  }

  Future<String> _fetchGreeting() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Загрузка завершена! Данные из Future получены.';
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              future: _statusFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                print("скоро будет");
              },
              icon: const Icon(Icons.notifications),
              label: const Text('Отправить пуш-уведомление'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Перейти на второй !!!!!!!!!!!!!!!экран (pushNamed)'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Второй экран')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Вернуться назад'),
        ),
      ),
    );
  }
}
