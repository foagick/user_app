class Product {
	const Product({
		required this.id,
		required this.title,
		required this.price,
		required this.category,
		required this.description,
	});

	final String id;
	final String title;
	final double price;
	final String category;
	final String description;
}

class CartItem {
	CartItem({
		required this.product,
		required this.quantity,
	});

	final Product product;
	int quantity;

	double get total => product.price * quantity;
}
