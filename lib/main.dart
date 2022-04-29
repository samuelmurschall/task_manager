import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/blocs/task/task_bloc.dart';
import 'package:task_manager/hive_database.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  final hiveDatabase = HiveDataBase();
  await hiveDatabase.openBox();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp(
    hiveDataBase: hiveDatabase,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required HiveDataBase hiveDataBase})
      : _hiveDataBase = hiveDataBase,
        super(key: key);

  final HiveDataBase _hiveDataBase;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _hiveDataBase,
      child: BlocProvider(
        create: (context) =>
            TaskBloc(hiveDataBase: _hiveDataBase)..add(LoadTask()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            splashColor: Colors.transparent,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
