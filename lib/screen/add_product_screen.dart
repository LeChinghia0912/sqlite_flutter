import 'package:flutter/material.dart';

import '../model/product.dart';
import '../service/productservice.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}
class _AddProductFormState extends State<AddProductForm> {
  late ProductService service;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController = TextEditingController();
  connectDatabase() async{
    service=ProductService(await getDatabase());
  }
  @override
  void initState() {
    connectDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _productIdController,
                decoration: const InputDecoration(
                  labelText: 'Mã sản phẩm',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hãy nhập mã';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: 'Tên sản phẩm',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hãy nhập tên';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productPriceController,
                decoration: const InputDecoration(
                  labelText: 'Giá',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hãy nhập giá';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productQuantityController,
                decoration: const InputDecoration(
                  labelText: 'Số lượng',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hãy nhập số lượng';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the data, for example, add the product to a list
                      // or send it to an API
                      String productId=_productIdController.text;
                      String productName = _productNameController.text;
                      int price =int.parse(_productPriceController.text);
                      int quantity =int.parse(_productQuantityController.text);
                      service.insert(Product(productId, productName, price, quantity));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thêm thành công!')));
                      _productIdController.clear();
                      _productNameController.clear();
                      _productPriceController.clear();
                      _productQuantityController.clear();
                    }
                  },
                  child: const Text('Lưu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}