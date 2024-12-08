class CategoryModel {
  final String title;
  final String info;

  final String? image, svgSrc;
  final List<CategoryModel>? subCategories;
  final String? paytipe;
  final String? address;
  final bool? isSelected;
  final bool? ignoreExpansion;
  CategoryModel(
      {required this.title,
      required this.info,
      this.image,
      this.svgSrc,
      this.subCategories,
      this.paytipe,
      this.address,
      this.isSelected,
      this.ignoreExpansion});
}

// final List<CategoryModel> demoCategoriesWithImage = [
//   CategoryModel(
//       title: "Delivery",
//       info: 'Select address',
//       image: "https://i.imgur.com/5M89G2P.png"),
//   CategoryModel(
//       title: "Payment",
//       info: 'Select Payment',
//       image: "https://i.imgur.com/UM3GdWg.png"),
//   CategoryModel(
//       title: "Promo Code",
//       info: 'Pick discount',
//       image: "https://i.imgur.com/Lp0D6k5.png"),
//   CategoryModel(
//       title: "Total Cost",
//       info: 'Total cost',
//       image: "https://i.imgur.com/3mSE5sN.png"),
// ];

// final List<CategoryModel> demoCategories = [
//   CategoryModel(
//     title: "Delivery",
//     info: 'Select address',
//     subCategories: [
//       CategoryModel(title: "Home", info: 'Davtashen street 4 / 18 '),
//       CategoryModel(title: "workplace", info: 'Komitas street 54/V'),
//       CategoryModel(title: "Friends home", info: 'Khachatur Abovyan str... '),
//     ],
//   ),
//   CategoryModel(
//     title: "Payment",
//     info: 'Select Payment',
//     subCategories: [
//       CategoryModel(title: "Payment 1", info: 'Payment info'),
//       CategoryModel(title: "Payment 2", info: 'Payment info'),
//     ],
//   ),
//   CategoryModel(
//     title: "Promo Code",
//     info: 'Pick discount',
//     subCategories: [
//       CategoryModel(title: "2000֏", info: 'Valid until 20/11/2024'),
//       CategoryModel(title: "1000֏", info: 'Valid until 20/11/2024'),
//       CategoryModel(title: "500֏", info: 'Valid until 20/11/2024'),
//     ],
//   ),
//   CategoryModel(
//     title: "Total Cost",
//     info: '7500֏',
//     subCategories: [],
//   ),
// ];
