import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:task/core/const/def_theme.dart';
import 'package:task/core/network/dio/dio_api_client.dart';
import 'package:task/core/repository/employee_repositpory/employee_repositpory.dart';
import 'package:task/core/repository/employee_repositpory/employee_repositpory_impl.dart';
import 'package:task/route/route_generator.dart';
import 'package:task/ui/base/base_screen.dart';

import 'core/binding/app_binding.dart';
import 'core/network/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingletonAsync<ApiClient>(() => DioApiClient.getInstance());

  GetIt.I.registerSingletonWithDependencies<EmployeeRepository>(
    () => EmployeeRepositoryImpl(),
    dependsOn: [ApiClient],
  );

  await GetIt.I.allReady();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child as Widget,
      ),
      title: 'Task',
      theme: DefTheme.themeData,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: BaseScreen.routeName,
      getPages: routes,
    );
  }
}
