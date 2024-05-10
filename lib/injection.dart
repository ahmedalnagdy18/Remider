import 'package:get_it/get_it.dart';
import 'package:reminder_app/features/calendar/data/data_sources/remote_data_source.dart';
import 'package:reminder_app/features/calendar/data/repository_imp/repository_imp.dart';

import 'package:reminder_app/features/calendar/data/api_services.dart/data_source.dart';

GetIt sl = GetIt.instance;

void setupinjection() {
  sl.registerSingleton<TaskRepoImp>(TaskRepoImp(
      dataSource: CalendarRemoteDataSource(dataSource: FirebaseDataSource())));
}
