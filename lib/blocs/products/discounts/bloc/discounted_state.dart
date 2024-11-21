part of 'discounted_bloc.dart';

sealed class DiscountedBlocState extends Equatable {
  const DiscountedBlocState();

  @override
  List<Object> get props => [];
}

final class DiscountedBlocInitial extends DiscountedBlocState {}

class DiscountedBlocLoading extends DiscountedBlocState {}

class DiscountedBlocLoaded extends DiscountedBlocState {
  final List<Product> discountedProducts; // Replace `Product` with your model
  DiscountedBlocLoaded(this.discountedProducts);
}

class DiscountedBlocError extends DiscountedBlocState {
  final String message;
  DiscountedBlocError(this.message);
}
