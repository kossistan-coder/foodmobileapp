import 'package:flutter/material.dart';
class SpecialCard extends StatefulWidget {
  const SpecialCard({Key? key}) : super(key: key);

  @override
  State<SpecialCard> createState() => _SpecialCardState();
}

class _SpecialCardState extends State<SpecialCard> {
  @override
  Widget build(BuildContext context) {
    final List SpecialFoods = [
      {
        'id': 8,
        'url': "images/menu-3.jpg",
        'price': "17",
        'nom': "Jambon Frommage",
        'time': "25"
      },
      {
        'id': 7,
        'url': "images/menu-2.jpg",
        'price': "17",
        'nom': "Burger Brand",
        'time': "30"
      },
      {
        'id': 9,
        'url': "images/menu-5.jpg",
        'price': "17",
        'nom': "Fried Cake",
        'time': "28"
      },
    ];
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text("Speciality"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child : Column(
      children: SpecialFoods.map((e) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 228, 226, 226),
                  spreadRadius: 1,
                  offset: Offset(0, 1))
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 10,
                  left: 10,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(e['url']),
                
                  ),
              Positioned(
                  left: 180,
                  top: 20,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e['nom'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text("price : " + "\$" + e['price']),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Delivery time : " + e['time'] + " min")
                      ])),
              Positioned(
                  right: 5,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: Icon(Icons.favorite))))
            ],
          ),
        );
      }).toList(),
    ),
      )
    );
  }
}