import 'package:equatable/equatable.dart';

class MyFormState extends Equatable {
  final bool isEditing;
  const MyFormState({required this.isEditing});
  @override
  List<Object?> get props => [isEditing];

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
  List<Object?> get props => [isEditing];
}

class MyFormErrorState extends MyFormState {
  const MyFormErrorState() : super(isEditing: true);

  @override
  List<Object?> get props => [isEditing];
}
