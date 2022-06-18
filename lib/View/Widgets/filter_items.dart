import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:bul_app/View-Model/Provider/lost_items_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterItems extends StatelessWidget {
  const FilterItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PublishProvider>(context);
    var lostItemsProvider = Provider.of<LostItemsProvider>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(top: 20.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BuildTitle(),
            buildSelectCityDropdownButton(provider),
            buildSelectRegionDropdownButton(provider),
            buildSelectCategoryDropdownButton(provider),
            buildSubmitButton(lostItemsProvider, provider, context)
          ],
        ),
      ),
    );
  }

  Align buildSubmitButton(LostItemsProvider lostItemsProvider,
      PublishProvider provider, BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
            onPressed: () {
              submit(lostItemsProvider, provider, context);
            },
            child: const Text("Onayla")));
  }

  Future<void> submit(LostItemsProvider lostItemsProvider,
      PublishProvider provider, BuildContext context) async {
    Navigator.pop(context);
    lostItemsProvider.items = await lostItemsProvider.fetchLostItems();
    bool isSelectCity = provider.selectedCity == "Şehir Seçiniz";
    bool isSelectRegion = provider.selectedRegion == "İlçe Seçiniz";
    bool isSelectCategory = provider.selectedCategory == "Kategori Seçiniz";

    if (isSelectCategory && isSelectRegion && isSelectCity) {
      lostItemsProvider.items = await lostItemsProvider.fetchLostItems();
    } else if (!isSelectCity && isSelectCategory && isSelectRegion) {
      lostItemsProvider.items =
          lostItemsProvider.filterByCity(provider.selectedCity!);
    } else if (!isSelectCity && !isSelectRegion && isSelectCategory) {
      lostItemsProvider.items = lostItemsProvider.filterByCityAndRegion(
          provider.selectedCity!, provider.selectedRegion!);
    } else if (!isSelectCity && isSelectRegion && !isSelectCategory) {
      lostItemsProvider.items = lostItemsProvider.filterByCityAndCategory(
          provider.selectedCity!, provider.selectedCategory!);
    } else if (isSelectCity && isSelectRegion && !isSelectCategory) {
      lostItemsProvider.items =
          lostItemsProvider.filterByCategory(provider.selectedCategory!);
    } else if (!isSelectCity && !isSelectRegion && !isSelectCategory) {
      lostItemsProvider.items =
          lostItemsProvider.filterByCityAndRegionAndCategory(
              provider.selectedCity!,
              provider.selectedRegion!,
              provider.selectedCategory!);
    }
  }

  DropdownButton<String> buildSelectCategoryDropdownButton(
      PublishProvider provider) {
    return DropdownButton<String>(
      value: provider.selectedCategory,
      items: provider.categories.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          child: Text(e.name!),
          value: e.name,
        );
      }).toList(),
      onChanged: (value) {
        provider.selectedCategory = value!;
      },
    );
  }

  DropdownButton<String> buildSelectRegionDropdownButton(
      PublishProvider provider) {
    return DropdownButton<String>(
        value: provider.selectedRegion,
        items: provider.regions
            .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: (value) {
          provider.selectedRegion = value!;
        });
  }

  DropdownButton<String> buildSelectCityDropdownButton(
      PublishProvider provider) {
    return DropdownButton<String>(
        value: provider.selectedCity,
        items: provider.cities
            .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                  child: Text(e.il!),
                  value: e.il,
                ))
            .toList(),
        onChanged: (value) {
          provider.selectedCity = value!;
          provider.fetchRegion(provider.selectedCity!);
          provider.selectedRegion = "İlçe Seçiniz";
        });
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Filtrele",
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }
}
