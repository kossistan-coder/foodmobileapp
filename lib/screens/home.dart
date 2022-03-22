import 'package:flutter/material.dart';
import 'package:foodmobileapp/constant.dart';
import 'package:foodmobileapp/models/api_response.dart';
import 'package:foodmobileapp/models/post.dart';
import 'package:foodmobileapp/screens/login.dart';
import 'package:foodmobileapp/screens/speciality.dart';
import 'package:foodmobileapp/services/post_service.dart';
import 'package:foodmobileapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final drawerItems = ListView(
      children: [
        UserAccountsDrawerHeader(
            accountName: Text("Thomas"),
            accountEmail: Text("thomas@gmail.com")),
        ListTile(
          title: Text("BurgerShop"),
          leading: Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: Row(
          children: [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchSection(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity / 2,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Align(
                            child: Row(
                              children: [
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Align(
                            child: Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 0;
                                    });
                                  },
                                  child: Text("our dishes"),
                                  style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialCard()));
                                  },
                                  child: Text("Today's speciality"),
                                  style: OutlinedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Card()
          ],
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);
  @override
  _SearchSectionState createState() {
    return _SearchSectionState();
  }
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "What would you like to order ?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "Find your food",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Search a food",
                    border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Card extends StatefulWidget {
  const Card({Key? key}) : super(key: key);
  @override
  _CardState createState() {
    return _CardState();
  }
}

class _CardState extends State<Card> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List foods = [
      {
        'id': 1,
        'url': "images/dish-4.png",
        'price': " 23",
        'nom': "Tasty Food",
        'time': "27"
      },
      {
        'id': 2,
        'url': "images/home-img-1.png",
        'price': " 27",
        'nom': "Spaghetti bolonaise",
        'time': "43"
      },
      {
        'id': 3,
        'url': "images/dish-1.png",
        'price': " 31",
        'nom': "Burger Shop",
        'time': "35"
      },
      {
        'id': 4,
        'url': "images/dish-3.png",
        'price': " 40",
        'nom': "Fried Chicken",
        'time': "53"
      },
      {
        'id': 5,
        'url': "images/dish-6.png",
        'price': " 38",
        'nom': "Somon Poulet",
        'time': "52"
      },
      {
        'id': 6,
        'url': "images/home-img-3.png",
        'price': " 17",
        'nom': "Pizza Royal",
        'time': "30"
      },
    ];
    return Column(
      children: foods.map((e) {
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
                  child: Image.asset(e['url'])),
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
    );
  }
}
