import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());
  static CheckOutCubit get(context) => BlocProvider.of(context);
  TextEditingController phoneController = TextEditingController();
  TextEditingController parentPhoneController = TextEditingController();
  // TextEditingController governmentController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  String roomType = '';
  String period = '';
  String periodShow = '';
  String payment = '';
  String? government;
  DateTime? startDate;
  DateTime? endDate;
  String? startFormatedDate;
  String? endFormatedDate;
  // Future<void> postBooking(DataBooking entity) async {
  //   emit(BookingLoading());

  //   var result = await bookingRepos.postBooking(entity);
  //   result.fold((failure) {
  //     emit(BookingFailure(failure.errorMsg));
  //   }, (response) {
  //     emit(BookingSuccess());

  //     print(
  //         'BBBBBBBBBBBBBBBOooooooooooooooookiiiiiiiiindf suuuuuuuuuucccccccccceeeeeessss');
  //   });
  // }

  // Future<void> getBooked() async {
  //   emit(BookedLoading());
  //   List<String> name = [];
  //   var result = await bookingRepos.getBooking();
  //   // var result2 = await bookingRepos.getBookingDetails(roomId);
  //   result.fold((failure) {
  //     emit(BookedFailure(failure.errorMsg));
  //   }, (response) async {
  //     print('ffffffffffffffffffffffffffffffffffff');
  //     print(response);
  //     if (response.data != null && response.data!.isNotEmpty) {
  //       for (var i = 0; i < response.data!.length; i++) {
  //         String bookedDetail = await getBookedDetails(response.data![i].room!);
  //         name.add(bookedDetail);
  //         print(name);
  //       }
  //     }
  //     emit(BookedSuccess(data: response.data ?? [], dataname: name));
  //     print(
  //         'BBBBBBBBBBBBBBBOooooooooooooooookiiiiiiiiindf geeeeeeeeeeeettttttt');
  //   });
  // }

  // Future<String> getBookedDetails(String roomId) async {
  //   var result = await bookingRepos.getBookingDetails(roomId);
  //   String detail = result.fold(
  //     (failure) {
  //       return "";
  //     },
  //     (response) {
  //       return response.data!.type!;
  //     },
  //   );
  //   return detail;
  // }
}
