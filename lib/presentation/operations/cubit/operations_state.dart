part of 'operations_cubit.dart';

@immutable
abstract class OperationsState {}

class OperationsInitial extends OperationsState {}

class OperationsLoading extends OperationsState {}

class OperationsLoaded extends OperationsState {
  final List<OperationModel> operations;
  OperationsLoaded({required this.operations});
}

class OperationsError extends OperationsState {
  final String message;
  OperationsError({required this.message});
}
