import 'package:flutter/material.dart';
import 'package:uber_eats/Components.dart';
import 'package:uber_eats/MealData.dart';
import 'package:uber_eats/OrderPage.dart';

import 'Backend/App.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  @override
  void dispose() {
    App.selectedMeal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();

    final bar = ValueListenableBuilder(
      valueListenable: App.selectedMeal,
      builder: (context,value,child){
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 10,left: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "UBER EATS",
                  style: TextStyle(
                      fontFamily: "Times",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
                GestureDetector(
                  child:Container(
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.all(2),
                    child:  Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage("Icons/shopping.png"),
                            width: 33,
                            height: 33,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(0xffc11e2c),
                            child: Text(
                              value.length.toString(),
                              style: TextStyle(
                                  fontFamily: "Times",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage()));

                  },
                )
              ],
            ),
          )
        );
      }
    );


    final searchbar = Container(
      height: 40,
      padding: EdgeInsets.only(right: 10,left: 10),
      child: TextField(
        controller: search,
        keyboardType: TextInputType.text,
        style: TextStyle(
          height: 1,
          fontFamily: "Times",
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.black
        ),
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2,color: Colors.black),
            borderRadius: BorderRadius.circular(6)
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.black),
              borderRadius: BorderRadius.circular(6)
          ),
        ),
      ),
    );

    final window  = Column(
      children: [
        bar,
        // SizedBox(height: 0,),
        searchbar,
        SizedBox(height: 10,),
        Expanded(
          child: GridView.extent(
            mainAxisSpacing: 0,
            padding: EdgeInsets.only(bottom: 10),
            shrinkWrap: false,
            childAspectRatio: 5/6,
            maxCrossAxisExtent: 200,
            children: [
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Rice", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Rice", price: 2500, image_Link: "Icons/chicken.png"),),
              Meal(meal: MealData(id: 1, name: "Chicken noodle", price: 2500, image_Link: "Icons/chicken.png"),),
            ],
          )
        )
      ],
    );

    return Container(
      padding: EdgeInsets.all(0),
      child: Scaffold(
        body: window,
        backgroundColor: Colors.white,
      ),
    );
  }

}