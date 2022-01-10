import 'package:equatable/equatable.dart';

class MyFormState extends Equatable {
  const MyFormState({required this.isEditing});
  final bool isEditing;

  @override
  List<Object?> get props => <Object?>[isEditing];
}

class MyFormSuccessState extends MyFormState {
  const MyFormSuccessState() : super(isEditing: true);

  @override
  List<Object?> get props => <Object?>[isEditing];
}

class MyFormErrorState extends MyFormState {
  const MyFormErrorState({required this.errorMap}) : super(isEditing: true);
  final Map<String, String?> errorMap;

  @override
  List<Object?> get props => <Object?>[errorMap, isEditing];
}
