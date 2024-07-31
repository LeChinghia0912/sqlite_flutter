import 'package:flutter/material.dart';
import '../model/product.dart';
import '../service/productservice.dart';

class DetailProduct extends StatefulWidget {
  String id;

  DetailProduct(this.id, {super.key});

  @override
  State<StatefulWidget> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  late ProductService service;
  Product p = Product("", "", 0, 0);

  getProduct() async {
    service = ProductService(await getDatabase());
    var data = await service.getById(widget.id);
    setState(() {
      p = data;
    });
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin chi tiết sản phẩm"),
      ),
      body: Container(
        margin: const EdgeInsets.all((10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mã sản phẩm: ${p.productId}'),
            const SizedBox(
              height: 10,
            ),
            Text('Tên sản phẩm: ${p.productName}'),
            const SizedBox(
              height: 10,
            ),
            Text('Giá: ${p.price}'),
            const SizedBox(
              height: 10,
            ),
            Text('Số lươợng: ${p.quantity}'),
          ],
        ),
      ),
    );
  }
}
