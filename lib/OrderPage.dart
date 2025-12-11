import 'package:flutter/material.dart';
import 'package:uber_eats/Components.dart';

import 'App.dart';

class OrderPage extends StatelessWidget{
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bar = AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Order",
        style: TextStyle(
            fontFamily: "Times",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
      ),
      actions: [
        IconButton(
          iconSize: 30,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 28,
            color: Colors.black,
          )
        ),
      ],
    );

    final window = Container(
      padding: EdgeInsets.only(right: 10,left: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemExtent: 75,
              itemCount: App.selectedMeal.value.length,
              itemBuilder: (BuildContext context, int index){
                return CartMeal(meal: App.selectedMeal.value[index]);
              }
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontFamily: "Times",
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: App.totalPrice,
                      builder: (context,value,child){
                        return Text(
                          "KES $value",
                          style: TextStyle(
                              fontFamily: "Times",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        );
                      }
                    )
                  ],
                ),
                SizedBox(height: 5,),
                SafeArea(
                  top: false,
                  bottom: true,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.all(0),
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffc11e2c),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontFamily: "Times",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );

    return Scaffold(
      appBar: bar,
      body: window,
    );
  }
}
