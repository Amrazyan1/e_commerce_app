// For demo only

import 'package:e_commerce_app/constants.dart';

class ProductModel {
  final String imageUrl, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  bool isFavourite;
  ProductModel({
    required this.imageUrl,
    required this.brandName,
    required this.title,
    required this.price,
    this.isFavourite = false,
    this.priceAfetDiscount,
    this.dicountpercent,
  });
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
      imageUrl: productDemoImg1,
      title: "Banana",
      brandName: "Custom Store",
      price: 540,
      priceAfetDiscount: 420,
      dicountpercent: 20,
      isFavourite: false),
  ProductModel(
      imageUrl: productDemoImg4,
      title: "Banana",
      brandName: "Custom Store",
      price: 800,
      isFavourite: false),
  ProductModel(
    imageUrl: productDemoImg5,
    title: "Bannana",
    brandName: "Custom Store",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    imageUrl: productDemoImg6,
    title: "Bananna",
    brandName: "City",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawwberry",
    brandName: "Straw",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    imageUrl:
        "https://thumbs.dreamstime.com/b/green-apple-isolated-white-png-image-transparent-background-green-apple-isolated-white-137311568.jpg",
    title: "Apple",
    brandName: "Apple",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
];
List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    imageUrl: productDemoImg5,
    title: "Store",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    imageUrl: productDemoImg6,
    title: "Strawberry",
    brandName: "Banana",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    imageUrl: productDemoImg4,
    title: "Yerevan city",
    brandName: "Banana",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawberry",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "store",
    brandName: "Banana",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    imageUrl: productDemoImg4,
    title: "Yerevan city",
    brandName: "Banana",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawberry",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 590.36,
    dicountpercent: 24,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Banana",
    price: 650.62,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Banana",
    price: 400,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Green Yerevan city",
    brandName: "Banana",
    price: 400,
    priceAfetDiscount: 360,
    dicountpercent: 20,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Banana",
    price: 654,
  ),
  ProductModel(
    imageUrl: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Yerevan city",
    brandName: "Banana",
    price: 250,
  ),
];
