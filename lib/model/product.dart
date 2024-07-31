class Product{
  String productId;
  String productName;
  int price;
  int quantity;

  Product(this.productId, this.productName, this.price, this.quantity);

  Map<String, Object?> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }
}