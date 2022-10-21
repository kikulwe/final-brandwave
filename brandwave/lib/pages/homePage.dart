import 'package:brandwave/models/CustomUser.dart';
import "package:flutter/material.dart";
import 'package:brandwave/utils/serviceCard.dart';
import 'package:brandwave/utils/recentAdCard.dart';

import 'package:brandwave/services/auth.dart';
import "package:provider/provider.dart";
import "package:brandwave/services/database.dart";

import 'package:brandwave/models/Adverts.dart';

class HomePage extends StatefulWidget {

  final CustomUser ? user;
  const HomePage({
    super.key,
    this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  static const List<Widget>_widgetOptions = [
    AppIntro(),
    AdvertList(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<CustomUser?>((context));

    return SafeArea(
      child: StreamProvider<List<Advert>?>.value(
        value: DatabaseService().adverts,
        initialData: null,
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopify_outlined),
                label: 'Adverts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 58, 144, 214),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class AppIntro extends StatelessWidget {
  const AppIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final adverts = Provider.of<List<Advert>>(context);
    final user = Provider.of<CustomUser?>((context));

    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Brandwave",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Divider(height: 5.0,color: Colors.transparent,),
                      Text(
                        "Good Morning",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(220, 36, 37, 37),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/images/profiledefault.png",
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Our Services",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(220, 36, 37, 37),
                  ),
                ),
              ),
              const Divider(height: 10.0,color: Colors.transparent,),
              Wrap(
                spacing: 5.0,
                runSpacing: 4.0,
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: const [
                  ServiceCard(serviceName: "Upload Ad", serviceIcon: Icons.upload,route: '/uploadAd'),
                  ServiceCard(serviceName: "Make Payment", serviceIcon: Icons.payments_sharp,route: '/deposit'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Recent Ads",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(220, 36, 37, 37),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: adverts.map((advert) {
                  if (advert.uid == user!.uid) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RecentAdvertCard(
                          imageUrl: advert.imageUrl,
                          name: advert.adName,
                        location: advert.location,
                          description: advert.description
                      ),
                    );
                  }
                  else {
                    return const SizedBox(height: 0,);
                  }
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdvertList extends StatefulWidget {
  const AdvertList({super.key});

  @override
  State<AdvertList> createState() => _AdvertListState();
}

class _AdvertListState extends State<AdvertList> {
  @override

  String getUserData (CustomUser user) {
    dynamic result = DatabaseService().getUser(user!.uid.toString());
    print(result);

        return "test";
  }

  Widget build(BuildContext context) {

    final adverts = Provider.of<List<Advert>>(context);
    final user = Provider.of<CustomUser?>((context));

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,

      children: adverts.map((advert) {
        if (advert.uid == user!.uid) {
          return const SizedBox(height: 0.0);
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: AdvertCard(
            advertName: advert.adName,
            advertDescription: advert.description,
            location: advert.location,
            username: getUserData(user),
            advertImageUrl: advert.imageUrl
          ),
        );
      }).toList(),

    );
  }
}

class AdvertCard extends StatelessWidget {

  final String ? username;
  final String location;
  final String advertName;
  final String advertDescription;
  final String advertImageUrl;


  const AdvertCard({
    this.username,
    required this.location,
    required this.advertName,
    required this.advertDescription,
    required this.advertImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(206, 255, 255, 255),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(62, 202, 202, 202),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username!,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                          Icons.location_on_outlined,
                          size: 15.0,
                          color: Color.fromARGB(179, 148, 148, 148)
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        location,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(179, 148, 148, 148)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: 350,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  advertImageUrl,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advertName,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    advertDescription,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(0, 0, 0, .7),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>((context));

    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.7),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: FittedBox(
                          child: Image.asset(
                            "assets/images/profiledefault.png",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(62, 202, 202, 202),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // ProfileDetail(label: "Username", value: "Andrew"),
                    // SizedBox(height: 20.0),
                    // ProfileDetail(label: "Full Name", value: "Kikulwe Andrew"),
                    // SizedBox(height: 20.0),
                    ProfileDetail(label: "Email", value: user!.email),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      dynamic result = await _auth.signOut();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Sign Out", style: TextStyle(fontSize: 17.0),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}

class ProfileDetail extends StatelessWidget {

  final String ? label;
  final String ? value;

  const ProfileDetail({
    this.label,
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0
            )
        ),
        const SizedBox(width: 10.0),
        Text(
            value!,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              color: Colors.black45
            )
        ),
      ],
    );
  }
}
