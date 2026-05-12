import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_farm_app/data/models/operation_model.dart';
import 'package:smart_farm_app/data/sources/operations_api.dart';
import 'package:intl/intl.dart';

part 'operations_state.dart';

class OperationsCubit extends Cubit<OperationsState> {
  final OperationsApi api;

  OperationsCubit({OperationsApi? api})
    : api = api ?? OperationsApi(),
      super(OperationsInitial());

  Future<void> loadOperations() async {
    emit(OperationsLoading());
    try {
      final list = await api.getOperations();
      emit(OperationsLoaded(operations: list));
    } catch (e) {
      emit(OperationsError(message: _formatError(e)));
    }
  }

  Future<void> refresh() async => await loadOperations();

  Future<void> loadOperationById(int id) async {
    emit(OperationsLoading());
    try {
      final op = await api.getOperationById(id);
      if (op != null) {
        emit(OperationsLoaded(operations: [op]));
      } else {
        emit(OperationsError(message: "Operation not found"));
      }
    } catch (e) {
      emit(OperationsError(message: _formatError(e)));
    }
  }

  
  Future<void> loadByType(int? type) async {
    emit(OperationsLoading());
    try {
      List<OperationModel> list;
      if (type == null) {
        list = await api.getOperations();
      } else {
        switch (type) {
          case 0:
            list = await api.getAgricultureOperations();
            break;
          case 1:
            list = await api.getHarvestOperations();
            break;
          case 2:
            list = await api.getRemoveHarmfulOperations();
            break;
          default:
            list = await api.getOperations();
        }
      }
      emit(OperationsLoaded(operations: list));
    } catch (e) {
      emit(OperationsError(message: _formatError(e)));
    }
  }

  String formatDateTime(DateTime dt) =>
      DateFormat('yyyy-MM-dd h:mm a').format(dt.toLocal());

  String _formatError(Object e) {
    final msg = e.toString();
    return msg.isEmpty ? 'Unknown error' : msg;
  }
}
