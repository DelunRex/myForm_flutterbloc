import 'package:equatable/equatable.dart';

class MyFormEvent extends Equatable {
  const MyFormEvent();

  @override
  List<Object?> get props => [];
}

class MyFormSubmitEvent extends MyFormEvent {
  final Map<String, String> formData;
  const MyFormSubmitEvent({
    required this.formData,
  }) : super();

  @override
  List<Object?> get props => [formData];
}

class MyFormEditingEvent extends MyFormEvent {
  const MyFormEditingEvent();
}

class MyFormSaveEvent extends MyFormEvent {
  const MyFormSaveEvent();
}
