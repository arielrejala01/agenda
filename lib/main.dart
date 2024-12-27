import 'package:agenda/pages.dart';
import 'package:agenda/reminder/bloc/reminder_bloc.dart';
import 'package:agenda/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyAppProviders()));
}

class MyAppProviders extends StatelessWidget {
  const MyAppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReminderBloc>(create: (context) => ReminderBloc()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
        ],
        locale: const Locale('es'),
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(76, 89, 153, 1),
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.white),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        routes: routes);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: Pages(
              index: selectedIndex,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add_reminder');
              },
              backgroundColor: const Color.fromRGBO(76, 89, 153, 1),
              child: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              selectedItemColor: const Color.fromRGBO(76, 89, 153, 1),
              unselectedItemColor: const Color.fromRGBO(160, 160, 160, 1),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.calendarDays), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.list), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.solidUser), label: ''),
              ],
            )),
      ),
    );
  }
}
