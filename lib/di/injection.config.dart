import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/data/sources/remote/datasources/employee_remote_datasource.dart';
import 'package:olivia_flutter_module/data/sources/remote/service/dio_client.dart';
import 'package:olivia_flutter_module/repositories/employee_repository.dart';

GetIt $initGetIt(GetIt getIt) {
  getIt.registerSingleton<DioService>(DioService(Dio()));

  registerDataSource(getIt);
  registerRepository(getIt);
  registerBloC(getIt);

  return getIt;
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(),
  );
}

void registerRepository(GetIt getIt) {
  getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl());
}

void registerBloC(GetIt getIt) {
  getIt.registerFactory<EmployeeBloc>(() => EmployeeBloc());
}
