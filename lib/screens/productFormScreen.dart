import 'package:flutter/material.dart';
import 'package:user_app/data/categories.dart';
import 'package:user_app/data/market_store.dart';
import 'package:user_app/models/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? productId;

  const ProductFormScreen({super.key, required this.productId});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _category = kCategories.first;
  bool get _isEditing => widget.productId != null;

  @override
  void initState() {
    final product = widget.productId;
    if (product != null) {
      _titleController.text = product.title;
      _priceController.text = product.price.toStringAsFixed(0);
      _descriptionController.text = product.description;
      _category = product.category;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a Title';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a Price';
    }

    final price = double.tryParse(value.trim());
    if (price == null) {
      return 'Enter a Valid number';
    }
    if (price <= 0) {
      return 'Price must be greater than 0';
    }
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text.trim();
    final price = double.parse(_priceController.text.trim());
    final description = _descriptionController.text.trim();

    if (_isEditing) {
      final product = widget.productId!;
      MarketStore.updateProduct(
        Product(
          id: product.id,
          title: title,
          price: price,
          category: _category,
          description: description,
        ),
      );
    } else {
      MarketStore.addProduct(
        Product(
          id: MarketStore.newProductId(),
          title: title,
          price: price,
          category: _category,
          description: description,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEditing ? 'Product updated' : 'Product added'),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit product' : 'Add product',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const _FieldLabel('Title'),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(hintText: 'Desk Top'),
                      validator: _validateTitle,
                    ),
                    SizedBox(height: 16),

                    const _FieldLabel('Price'),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: '0'),
                      validator: _validatePrice,
                    ),
                    SizedBox(height: 16),

                    const _FieldLabel('Category'),
                    DropdownButtonFormField(
                      initialValue: _category,
                      items: [
                        for (final category in kCategories)
                          DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _category = value);
                      },
                    ),
                    SizedBox(height: 16),

                    const _FieldLabel('Description'),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Short description',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Save changes' : 'Save product',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(color: Colors.grey)),
    );
  }
}
