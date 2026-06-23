import 'package:equatable/equatable.dart';

abstract class ZoneDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ZoneInitial extends ZoneDetailsState {}

class ZoneLoading extends ZoneDetailsState {}

class ZoneSuccess extends ZoneDetailsState {
  final String message;
  final String? cropName; 

  ZoneSuccess(this.message, {this.cropName});

  @override
  List<Object?> get props => [message, cropName];
}

class ZoneFailure extends ZoneDetailsState {
  final String error;
  ZoneFailure(this.error);

  @override
  List<Object?> get props => [error];
}
