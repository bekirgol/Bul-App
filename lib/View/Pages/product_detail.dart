import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Constand/public.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/View-Model/Provider/lost_items_provider.dart';
import 'package:bul_app/View/Widgets/get_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Products products;
  final bool isAppBar;
  const ProductDetailPage(
      {Key? key, required this.products, required this.isAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lostItemProvider = Provider.of<LostItemsProvider>(context);
    return Scaffold(
      appBar: isAppBar ? buildAppBar(lostItemProvider) : null,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            buildImage(lostItemProvider),
            buildProduct(lostItemProvider),
            Card(
              child: ListTile(
                title: Text(products.category!),
                subtitle: Text(
                  "${products.createdAt!.day} ${Public.convertMonthToName(products.createdAt!.month)}",
                ),
                trailing: ElevatedButton(
                  child: const Text("Haritada\nGöster"),
                  onPressed: () {
                    showMap(products, context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProduct(LostItemsProvider lostItemProvider) {
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(products.title!),
              subtitle: Text(products.description!),
              trailing: Text('${products.city!}\n'
                  '${products.district}'),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(LostItemsProvider lostItemProvider) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      title: Card(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/640.png"),
              ),
              const SizedBox(width: 10.0),
              Text(products.userId!.name!),
              const SizedBox(width: 3.0),
              Text(products.userId!.lastName!)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(LostItemsProvider lostItemProvider) {
    return Card(
      elevation: 10.0,
      child: Image.network(
        products.imageUrl!
            .replaceAll("http://localhost:3000", Constand.BASE_URL),
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/images/no_picture.png"),
      ),
    );
  }

  void showMap(Products products, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => GetMap(
        latLng: LatLng(
          double.parse(products.latitude!),
          double.parse(products.longitude!),
        ),
      ),
    );
  }
}
