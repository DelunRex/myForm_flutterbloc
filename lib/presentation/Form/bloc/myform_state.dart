import 'package:equatable/equatable.dart';

class MyFormState extends Equatable {
  const MyFormState({required this.isEditing});
  final bool isEditing;

  @override
  List<Object?> get props => <Object?>[isEditing];

  MyFormState copyWith({
    bool? isEditing,
  }) {
    return MyFormState(
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class MyFormSuccessState extends MyFormState {
  const MyFormSuccessState() : super(isEditing: true);

  @override
  List<Object?> get props => <Object?>[isEditing];
}

class MyFormErrorState extends MyFormState {
  const MyFormErrorState() : super(isEditing: true);

  @override
  List<Object?> get props => <Object?>[isEditing];
}
