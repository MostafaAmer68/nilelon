import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_register_state.dart';

class StoreRegisterCubit extends Cubit<StoreRegisterState> {
  StoreRegisterCubit() : super(StoreRegisterInitial());
  static StoreRegisterCubit get(context) =>
      BlocProvider.of<StoreRegisterCubit>(context);
  DateTime? date;
  String? dateFormatted;
}
