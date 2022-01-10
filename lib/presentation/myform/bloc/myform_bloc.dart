import 'package:bloc/bloc.dart';

import '../../../domain/repositories/user_repository.dart';
import '../../../globals.dart';
import 'myform_event.dart';
import 'myform_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc({required this.userRepository, required bool isEditing})
      : super(MyFormState(isEditing: isEditing)) {
    on<MyFormSubmitEvent>((MyFormSubmitEvent event, Emitter<MyFormState> emit) {
      final Map<String, String?> errorMap = <String, String?>{};
      bool isError = false;
      final Map<String, String> map = event.formData;
      map.forEach((String key, String value) {
        if (value == '') {
          isError = true;
          errorMap[key] = "$key Value can't be empty";
        } else {
          errorMap[key] = null;
        }
      });
      if (isError) {
        emit(MyFormErrorState(errorMap: errorMap));
      } else {
        userRepository.addFormDetails(
          map[nameKey]!,
          map[addressKey]!,
          map[bankAccountNumKey]!,
          map[bankIfscCodeKey]!,
        );
        userRepository.isFormDetailsSaved = true;
        emit(const MyFormSuccessState());
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
