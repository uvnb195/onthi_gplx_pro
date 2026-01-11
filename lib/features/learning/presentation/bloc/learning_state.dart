part of 'learning_bloc.dart';

sealed class LearningState extends Equatable {
  const LearningState();
  
  @override
  List<Object> get props => [];
}

final class LearningInitial extends LearningState {}
