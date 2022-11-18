class Product {
  final String id;
  final String title;
  final String description;
  final String formattedPrice;
  final double price;
  final String currencyCode;
  final String currencySymbol;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.formattedPrice,
    required this.price,
    required this.currencyCode,
    this.currencySymbol = '',
  });
}