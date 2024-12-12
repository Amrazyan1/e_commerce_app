part of 'product_detail_bloc.dart';


abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchProductDetail extends ProductDetailEvent {
  final String id;

  const FetchProductDetail(this.id);

  @override
  List<Object> get props => [id];
}