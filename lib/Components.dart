import 'package:flutter/material.dart';
import 'package:uber_eats/MealData.dart';
import 'App.dart';

class Meal extends StatelessWidget{
  final MealData meal;
  const Meal({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Color(0xffc1bfbf),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(meal.image_Link),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        height: 35,
                        width: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 10,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0)
                          ),
                          onPressed: (){
                            App.addMeal(meal);
                          },
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: Color(0xffc11e2c),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              )
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: TextStyle(
                      height: 1,
                      fontFamily: "Times",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    "KES ${meal.price.toString()}",
                    style: TextStyle(
                      fontFamily: "Times",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff11bd83)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}