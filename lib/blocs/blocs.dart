import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/core/common/exceptions.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializedState extends BaseState {}

class InProgressState extends BaseState {}

class DataChangedState<T> extends BaseState {
  final T data;

  DataChangedState(this.data);
}

class ErrorState extends BaseState {
  final BaseException exception;

  ErrorState(this.exception);
}

abstract class BaseBloc extends Cubit<BaseState> {
  BaseBloc() : super(InitializedState());
}

mixin SingleBlocMixin on BaseBloc {
  void single<T>(
    Future<T> Function() action, {
    required BaseState Function(T data) onSuccess,
  }) async {
    emit(InProgressState());
    try {
      T data = await action();
      emit(onSuccess(data));
    } on BaseException catch (exception) {
      emit(ErrorState(exception));
    } catch (error) {
      emit(ErrorState(LocalException(message: error.toString())));
    }
  }
}
