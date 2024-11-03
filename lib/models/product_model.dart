// For demo only

import 'package:e_commerce_app/constants.dart';

class ProductModel {
  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  bool isFavourite;
  ProductModel({
    required this.image,
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
      image: productDemoImg1,
      title: "Banana",
      brandName: "Custom Store",
      price: 540,
      priceAfetDiscount: 420,
      dicountpercent: 20,
      isFavourite: false),
  ProductModel(
      image: productDemoImg4,
      title: "Banana",
      brandName: "Custom Store",
      price: 800,
      isFavourite: false),
  ProductModel(
    image: productDemoImg5,
    title: "Bannana",
    brandName: "Custom Store",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Bananna",
    brandName: "City",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawwberry",
    brandName: "Straw",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image:
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
    image: productDemoImg5,
    title: "Store",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Strawberry",
    brandName: "Banana",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Yerevan city",
    brandName: "Banana",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawberry",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "store",
    brandName: "Banana",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Yerevan city",
    brandName: "Banana",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Strawberry",
    brandName: "Banana",
    price: 650.62,
    priceAfetDiscount: 590.36,
    dicountpercent: 24,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Banana",
    price: 650.62,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Banana",
    price: 400,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Green Yerevan city",
    brandName: "Banana",
    price: 400,
    priceAfetDiscount: 360,
    dicountpercent: 20,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Banana",
    price: 654,
  ),
  ProductModel(
    image: "https://pngimg.com/d/strawberry_PNG89.png",
    title: "Yerevan city",
    brandName: "Banana",
    price: 250,
  ),
];
