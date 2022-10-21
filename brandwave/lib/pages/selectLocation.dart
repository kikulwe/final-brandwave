import 'package:brandwave/services/database.dart';
import "package:flutter/material.dart";
import "package:brandwave/utils/screens.dart";
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import 'package:brandwave/models/CustomUser.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  Position ? coordinates;
  List<Placemark>? location;
  String ? exactLocation;


  Future getLocationName(Position clientPosition) async {
    return await placemarkFromCoordinates(clientPosition.latitude, clientPosition.longitude, localeIdentifier: "en");
  }

  Future getClientLocation () async {

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      // throw Exception('Error');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  @override
  void initState() {
    super.initState();


    getClientLocation()
        .then((clientPosition) => {
      getLocationName(clientPosition)
          .then((placements) => {
        setState(() {
          coordinates = clientPosition;

          setState(() {
            exactLocation = placements[3].locality.toString();
          });
          // coordinates = clientPosition;
        })
      })
    });
  }

  void redirect() => Navigator.pushNamed(context, '/');


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AdvertScreenArguments;

    final user = Provider.of<CustomUser?>((context));

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(62, 202, 202, 202),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Current Location: ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      exactLocation ?? "Loading",
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(174, 239, 241, 241),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(62, 202, 202, 202),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () => {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black87,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/'),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Cancel", style: TextStyle(fontSize: 17.0),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                        ),
                        onPressed: () async {
                          await DatabaseService().addAdvert(
                            user!.uid,
                              args.name.toString(),
                              args.description.toString(),
                              exactLocation!,
                              args.files![0]
                          );
                          redirect();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Continue", style: TextStyle(fontSize: 17.0),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}