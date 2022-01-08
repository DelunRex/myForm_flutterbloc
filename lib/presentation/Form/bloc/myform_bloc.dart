import 'package:bloc/bloc.dart';

import '../../../data/constants/app_assets.dart';
import '../../../domain/repositories/user_repository.dart';
import 'myform_event.dart';
import 'myform_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc({required this.userRepository, required bool isEditing})
      : super(MyFormState(isEditing: isEditing)) {
    on<MyFormSubmitEvent>((MyFormSubmitEvent event, Emitter<MyFormState> emit) {
      try {
        userRepository.addFormDetails(
            event.formData[nameKey]!,
            event.formData[addressKey]!,
            event.formData[bankAccountNumKey]!,
            event.formData[bankIfscCodeKey]!);
        userRepository.isFormDetailsSaved = true;
        emit(const MyFormSuccessState());
      } catch (e) {
        emit(const MyFormErrorState());
      }
    });
    on<MyFormEditingEvent>(
        (MyFormEditingEvent event, Emitter<MyFormState> emit) {
      emit(const MyFormState(isEditing: true));
    });
    on<MyFormSaveEvent>((MyFormSaveEvent event, Emitter<MyFormState> emit) {
      emit(const MyFormState(isEditing: false));
    });
  }
  final UserRepository userRepository;
}
