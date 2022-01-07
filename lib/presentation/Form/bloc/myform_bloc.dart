import 'package:bloc/bloc.dart';
import 'package:myform/domain/repositories/user_repository.dart';
import 'package:myform/data/constants/app_assets.dart';

import 'myform_event.dart';
import 'myform_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  final UserRepository userRepository;

  MyFormBloc({required this.userRepository, required bool isEditing})
      : super(MyFormState(isEditing: isEditing)) {
    on<MyFormSubmitEvent>((event, emit) {
      try {
        userRepository.addFormDetails(
            event.formData[nameKey]!,
            event.formData[addressKey]!,
            event.formData[bankAccountNumKey]!,
            event.formData[bankIfscCodeKey]!);
        userRepository.isFormDetailsSaved = true;
        emit(MyFormSuccessState());
      } catch (e) {
        emit(MyFormErrorState());
      }
    });
    on<MyFormEditingEvent>((event, emit) {
      emit(MyFormState(isEditing: true));
    });
    on<MyFormSaveEvent>((event, emit) {
      emit(MyFormState(isEditing: false));
    });
  }
}
