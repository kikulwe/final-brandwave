import "package:flutter/material.dart";

class RecentAdvertCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String name;
  final String description;

  const RecentAdvertCard({
    Key? key,
    required this.imageUrl,
    required this.location,
    required this.name,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Container(
              height: 60.0,
              width: 80.0,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  imageUrl,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(220, 36, 37, 37),
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                        Icons.location_on_outlined,
                        size: 15.0,
                        color: Color.fromARGB(179, 148, 148, 148)
                    ),
                    const SizedBox(width: 2.5),
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
          ],
        ),
      ),
    );
  }
}