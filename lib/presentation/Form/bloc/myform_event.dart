import 'package:equatable/equatable.dart';

class MyFormEvent extends Equatable {
  const MyFormEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class MyFormSubmitEvent extends MyFormEvent {
  const MyFormSubmitEvent({
    required this.formData,
  }) : super();
  final Map<String, String> formData;

  @override
  List<Object?> get props => <Object?>[formData];
}

class MyFormEditingEvent extends MyFormEvent {
  const MyFormEditingEvent();
}

class MyFormSaveEvent extends MyFormEvent {
  const MyFormSaveEvent();
}
