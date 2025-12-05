import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget{
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bar = SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order",
              style: TextStyle(
                  fontFamily: "Times",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            ),
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
        ),
      )
    );

    final window = Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          bar
        ],
      ),
    );

    return Scaffold(
      body: window,
    );
  }
}
