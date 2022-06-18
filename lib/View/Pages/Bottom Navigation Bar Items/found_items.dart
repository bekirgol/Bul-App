// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Constand/public.dart';
import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/View-Model/Provider/found_item_provider.dart';
import 'package:bul_app/View/Pages/product_detail.dart';
import 'package:bul_app/View/Widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lostItemsProvider = Provider.of<FoundItemViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: Text(
          "Bulunanlar",
          style: Styles.headerStyle,
        ),
        backgroundColor: Colors.red[200],
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: lostItemsProvider.fetchItems,
        child: CustomScrollView(
          slivers: [
            BuildSliverAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
              Center(
                child: buildListViewBuilder(lostItemsProvider),
              ),
            ]))
          ],
        ),
      ),
    );
  }

  Widget buildListViewBuilder(FoundItemViewModel lostItemsProvider) {
    switch (lostItemsProvider.pageState) {
      case FoundItemPageState.LOADING:
        {
          return CircularProgressIndicator();
        }

      case FoundItemPageState.SUCCES:
        {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: lostItemsProvider.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                  isAppBar: true,
                                  products: lostItemsProvider.items[index])));
                    },
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: buildNameSurName(lostItemsProvider, index)),
                        Expanded(
                            flex: 13,
                            child: buildImage(lostItemsProvider, index)),
                        Expanded(
                            flex: 3,
                            child: buildTitle(lostItemsProvider, index)),
                        // Expanded(flex: 4, child: buildDescription()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      case FoundItemPageState.ERROR:
        {
          return Text("Hata");
        }

      default:
        {
          return Container();
        }
    }
  }

  Widget buildNameSurName(FoundItemViewModel lostItemsProvider, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${lostItemsProvider.items[index].userId!.name ?? " "} ${lostItemsProvider.items[index].userId!.lastName ?? " "}",
            style: Styles.cardTextStyle,
          ),
          Text(
            "${lostItemsProvider.items[index].createdAt!.day} ${Public.convertMonthToName(lostItemsProvider.items[index].createdAt!.month)}",
            style: Styles.cardTextStyle,
          ),
        ],
      ),
    );
  }

  Container buildImage(FoundItemViewModel lostItemsProvider, int index) {
    return Container(
      child: Image.network(
        "${lostItemsProvider.items[index].imageUrl!.replaceAll("http://localhost:3000", Constand.BASE_URL)}",
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/images/no_picture.png"),
      ),
    );
  }

  Widget buildTitle(FoundItemViewModel lostItemsProvider, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      width: double.infinity,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${lostItemsProvider.items[index].title}",
            style: Styles.cardTextStyle,
          ),
          Text(
            "${lostItemsProvider.items[index].category}",
            style: Styles.cardTextStyle,
          ),
        ],
      ),
    );
  }
}
