import 'package:flutter/material.dart';

import '../model/product.dart';
import '../service/productservice.dart';
import 'add_product_screen.dart';
import 'detail_product_screen.dart';
import 'edit_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  late ProductService service;

  getProducts() async {
    service = ProductService(await getDatabase());
    var data = await service.getAll();
    setState(() {
      products = data;
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DANH SÁCH SẢN PHẨM'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].productName),
            subtitle: Text('Giá:${products[index].price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProductForm(products[index].productId)))
                        .then((value) {
                      getProducts();
                    });
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      showConfirm(context, products[index].productId);
                    },
                    child: const Icon(Icons.delete))
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailProduct(products[index].productId)));
            },
          );
        },
        itemCount: products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductForm())).then((value) {
            getProducts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showConfirm(BuildContext context, String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Xóa sản phẩm?'),
              content: const Text('Bạn có muốn xóa sản phẩm này không?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Không')),
                TextButton(
                    onPressed: () {
                      service.delete(productId);
                      getProducts();
                      Navigator.pop(context);
                    },
                    child: const Text('Có')),
              ]);
        });
  }
}
