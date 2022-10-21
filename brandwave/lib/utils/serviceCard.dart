import "package:flutter/material.dart";

class ServiceCard extends StatelessWidget {

  final String serviceName;
  final IconData serviceIcon;
  final String route;

  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.serviceIcon,
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        child: Container(
          width: 155.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                serviceIcon,
                size: 40.0,
                color: const Color.fromRGBO(33, 150, 243, 1),
              ),
              const Divider(height: 5.0,color: Colors.transparent,),
              Text(
                serviceName,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(220, 36, 37, 37),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}