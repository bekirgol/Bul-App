// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Constand/public.dart';
import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/View-Model/Provider/lost_items_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:bul_app/View/Pages/product_detail.dart';
import 'package:bul_app/View/Widgets/appbar.dart';
import 'package:bul_app/View/Widgets/filter_items.dart';
import 'package:bul_app/View/Widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LostItemsPage extends StatelessWidget {
  const LostItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lostItemsProvider = Provider.of<LostItemsProvider>(context);
    // var publishProvider = Provider.of<PublishProvider>(context);
    // List<Products> product = lostItemsProvider.items
    //     .where((element) => element.city == publishProvider.selectedCity)
    //     .toList();
    return Scaffold(
        floatingActionButton: buildFloatingActionButton(context),
        backgroundColor: Colors.red[200],
        appBar: BuildAppBar(
          text: "Kayıplar",
        ),
        body: RefreshIndicator(
          onRefresh: lostItemsProvider.pullRefresh,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              BuildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [Center(child: buildListViewBuilder(lostItemsProvider))],
                ),
              )
            ],
          ),
        ));
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return FilterItems();
            });
      },
      child: Icon(Icons.format_list_numbered_rtl_outlined),
    );
  }

  Widget buildListViewBuilder(LostItemsProvider lostItemsProvider) {
    switch (lostItemsProvider.pageState) {
      case LostItemsPageState.LOADING:
        {
          return CircularProgressIndicator();
        }

      case LostItemsPageState.SUCCES:
        {
          return ListView.builder(
            itemCount: lostItemsProvider.items.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
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
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                    isAppBar: true,
                                    products: lostItemsProvider.items[index],
                                  )));
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
                        // Expanded(
                        //     flex: 4,
                        //     child: buildDescription(lostItemsProvider, index)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      case LostItemsPageState.ERROR:
        {
          return Text("Hata");
        }

      default:
        {
          return Container();
        }
    }
  }

  Widget buildNameSurName(LostItemsProvider lostItemsProvider, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${lostItemsProvider.items[index].userId!.name} ${lostItemsProvider.items[index].userId!.lastName}",
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

  Widget buildImage(LostItemsProvider lostItemsProvider, int index) {
    return Container(
      child: Image.network(
        "${lostItemsProvider.items[index].imageUrl!.replaceAll("http://localhost:3000", Constand.BASE_URL)}",
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/images/no_picture.png"),
      ),
    );
  }

  Widget buildTitle(LostItemsProvider lostItemsProvider, int index) {
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

  Container buildDescription(LostItemsProvider lostItemsProvider, int index) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.green,
      child: Text(lostItemsProvider.items[index].description!),
    );
  }
}
