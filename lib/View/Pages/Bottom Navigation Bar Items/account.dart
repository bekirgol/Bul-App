// ignore_for_file: prefer_const_constructors

import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:bul_app/View-Model/Provider/account_provider.dart';
import 'package:bul_app/View-Model/Provider/found_item_provider.dart';
import 'package:bul_app/View-Model/Provider/login_provider.dart';
import 'package:bul_app/View-Model/Provider/lost_items_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:bul_app/View/Pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginViewModel>(context);
    var lostItemsProvider = Provider.of<LostItemsProvider>(context);
    var foundItemsProvider = Provider.of<FoundItemViewModel>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: buildAppBar(loginProvider),
          body: TabBarView(
            children: [
              buildLostsTab(loginProvider, lostItemsProvider),
              buildFoundTab(loginProvider, foundItemsProvider),
            ],
          )),
    );
  }

  Widget buildFoundTab(
      LoginViewModel loginProvider, FoundItemViewModel foundItemProvider) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: foundItemProvider.itemsByUserId.length,
        itemBuilder: (BuildContext context, int index) {
          switch (foundItemProvider.pageState) {
            case FoundItemPageState.LOADING:
              {
                return CircularProgressIndicator();
              }
            case FoundItemPageState.SUCCES:
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                  products:
                                      foundItemProvider.itemsByUserId[index],
                                  isAppBar: true)));
                    },
                    child: Image.network(
                      foundItemProvider.itemsByUserId[index].imageUrl!
                          .replaceAll(
                              "http://localhost:3000", Constand.BASE_URL),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/no_picture.png"),
                    ),
                  ),
                );
              }

            case FoundItemPageState.ERROR:
              {
                return Text("Bir Hata Oluştu");
              }

            default:
              {
                return Text("Henüz Bir şey Paylaşmadınız!");
              }
          }
        },
      ),
    );
  }

  Widget buildLostsTab(
      LoginViewModel loginProvider, LostItemsProvider lostItemsProvider) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: lostItemsProvider.itemsByUserId.length,
        itemBuilder: (BuildContext context, int index) {
          if (lostItemsProvider.itemsByUserId.isEmpty) {
            return CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                            products: lostItemsProvider.itemsByUserId[index],
                            isAppBar: true)));
              },
              child: Image.network(
                lostItemsProvider.itemsByUserId[index].imageUrl!
                    .replaceAll("http://localhost:3000", Constand.BASE_URL),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/no_picture.png"),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(LoginViewModel loginProvider) {
    return AppBar(
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(
              child: Text("Kaybettiklerim",
                  style: TextStyle(color: Colors.black))),
          Tab(
              child:
                  Text("Bulduklarım", style: TextStyle(color: Colors.black))),
        ],
      ),
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
              Text(loginProvider.response!.name!),
              const SizedBox(width: 3.0),
              Text(loginProvider.response!.lastName!)
            ],
          ),
        ),
      ),
    );
  }
}
