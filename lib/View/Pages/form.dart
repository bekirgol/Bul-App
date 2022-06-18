// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/province.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:bul_app/View-Model/Provider/location_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:bul_app/View/Pages/home.dart';
import 'package:bul_app/View/Widgets/loading.dart';
import 'package:bul_app/View/Widgets/login_textfield.dart';
import 'package:bul_app/View/Widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatelessWidget {
  final String title;
  final String requests;
  // final void Function() function;

  const FormPage(
      {Key? key,
      required this.title,
      // required this.function,
      required this.requests})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var publishProvider = Provider.of<PublishProvider>(context);
    var locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: buildBodyColumn(publishProvider, context, locationProvider),
          ),
        ));
  }

  Widget buildBodyColumn(PublishProvider publishProvider, BuildContext context,
      LocationProvider locationProvider) {
    switch (publishProvider.pageState) {
      case PageState.LOADING:
        {
          return Loading();
        }

      case PageState.ERROR:
        {
          return SnackBar(content: Text(publishProvider.errorMessage));
        }

      case PageState.SUCCES:
        {
          return HomePage();
        }
      case PageState.IDLE:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(),
              // buildText(),
              buildTitleTextField(publishProvider),
              SizedBox(height: 10.0),
              buildDescriptionTextField(publishProvider),
              SizedBox(height: 10.0),

              buildSelectCategory(publishProvider),
              SizedBox(height: 10.0),

              publishProvider.image == null
                  ? ElevatedButton(
                      style: ButtonStyle(),
                      child: Text("Resim Ekle"),
                      onPressed: publishProvider.addImage,
                    )
                  : InkWell(
                      onTap: publishProvider.addImage,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child:
                              Image.file(File(publishProvider.image!.path)))),
              SizedBox(height: 10.0),

              publishProvider.placemark == null
                  ? ElevatedButton(
                      onPressed: () async {
                        getMap(context, publishProvider, locationProvider);
                      },
                      child: Text("Konum Ekle"))
                  : InkWell(
                      onTap: () {
                        getMap(context, publishProvider, locationProvider);
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${publishProvider.placemark?.first.administrativeArea!} "
                              '${publishProvider.placemark!.first.subAdministrativeArea!} '
                              '${publishProvider.placemark!.first.street!}'),
                        ),
                      ),
                    ),
              SizedBox(height: 10.0),

              buildSubmitButton(publishProvider, context),
              Container(),
            ],
          );
        }
      default:
        {
          return SizedBox.shrink();
        }
    }
  }

  SubmitButton buildSubmitButton(
      PublishProvider publishProvider, BuildContext context) {
    return SubmitButton(
      title: "ONAYLA",
      click: () async {
        // function();
        await publishProvider.addItems(requests);
        publishProvider.descriptionController.clear();
        publishProvider.titleController.clear();
        publishProvider.image = null;
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      },
    );
  }

  LoginTextField buildDescriptionTextField(PublishProvider publishProvider) {
    return LoginTextField(
      title: "Açıklama",
      textEditingController: publishProvider.descriptionController,
      textAlign: TextAlign.center,
    );
  }

  LoginTextField buildTitleTextField(PublishProvider publishProvider) {
    return LoginTextField(
      title: title,
      textEditingController: publishProvider.titleController,
      textAlign: TextAlign.center,
    );
  }

  Widget buildSelectCategory(PublishProvider publishProvider) {
    return DropdownButton<String>(
      value: publishProvider.selectedCategory,
      items: publishProvider.categories.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          child: Text(e.name!),
          value: e.name,
        );
      }).toList(),
      onChanged: (value) {
        publishProvider.selectedCategory = value!;
        // print(publishProvider.selectedItem);
      },
    );
  }

  getMap(context, PublishProvider publishProvider,
      LocationProvider locationProvider) async {
    Position? position = await locationProvider.getPermission();
    publishProvider.latLng = LatLng(position.latitude, position.longitude);

    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FlutterMap(
                options: MapOptions(
                  onPositionChanged: (mapPosition, boolValue) {
                    if (boolValue) {
                      publishProvider.latLng = mapPosition.bounds!.center;
                      // publishProvider.lat = mapPosition.bounds!.center.latitude;
                      // publishProvider.long =
                      //     mapPosition.bounds!.center.longitude;
                    }
                  },
                  center: publishProvider.latLng ??
                      LatLng(position.latitude, position.longitude),
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  // MarkerLayerOptions(
                  //   markers: [
                  //     Marker(
                  //       point: publishProvider.latLng ??
                  //           LatLng(position.latitude, position.longitude),
                  //       builder: (_) => Container(
                  //         child: Icon(
                  //           Icons.pin_drop,
                  //           color: Colors.blue,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: SubmitButton(
                    click: () async {
                      // publishProvider.latLng =
                      //     LatLng(position.latitude, position.longitude);
                      await publishProvider.getLocation();

                      Navigator.pop(context);
                    },
                    title: "Onayla"),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.pin_drop_rounded,
                  color: Colors.blue,
                  size: 30.0,
                ),
              ),
            ],
          );
        });
  }
}
