import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pw/cubit/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: "Практика 4",
            themeMode: themeProvider.themeMode,
            theme: Thema.lightTheme,
            darkTheme: Thema.darkTheme,
            home: BlocProvider(
              create: (_) => CubitCounter(),
              child: MyHomePage(),
            ),
          );
        },
      );
}

class MyHomePage extends StatelessWidget {
  late bool Thema;

  @override
  Widget build(BuildContext context) {
    Thema = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Практика 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CubitCounter, HomeState>(
                builder: (context, state) => Text(state.counter.toString(),
                    style: TextStyle(fontSize: 125))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<CubitCounter>().add(Thema ? 2 : 1);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                    ),
                    child: const Text("+", style: TextStyle(fontSize: 25))),
                ElevatedButton(
                    onPressed: () {
                      context.read<CubitCounter>().add(Thema ? -2 : -1);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                    ),
                    child: const Text("-", style: TextStyle(fontSize: 25))),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTh(!Thema);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(24),
              ),
              child: const Text("Тема"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTh(bool Th) {
    themeMode = Th ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Thema {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black26,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
  );
}
