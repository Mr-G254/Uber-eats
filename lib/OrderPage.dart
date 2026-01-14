import 'package:flutter/material.dart';
import 'package:status_snackbar/status_snackbar.dart';
import 'package:uber_eats/Components.dart';
import 'Backend/App.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>{
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      "Checkout",
      style: TextStyle(
        color: Colors.white,
        // fontWeight: FontWeight.bold,
        fontSize: 15
      ),
    );

    final loadingAnimation = Container(
      padding: EdgeInsets.all(0),
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        strokeWidth: 3,
        strokeCap: StrokeCap.round,
      ),
    );

    final bar = AppBar(
      backgroundColor: Colors.white,
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
                      onPressed: () async {
                        if(App.selectedMeal.value.isNotEmpty){
                          setState(() {
                            loading = true;
                          });

                          try{
                            bool success = await App.orderFood();

                            if(success){
                              if(context.mounted){
                                Navigator.pop(context);
                                StatusSnackbar.showSuccess(context, "Your order has been placed successfully");
                              }

                            }else{
                              setState(() {
                                loading = false;
                              });

                              if(context.mounted){
                                StatusSnackbar.showSuccess(context, App.currentErrorMessage);
                              }
                            }
                          }catch(e){
                            setState(() {
                              loading = false;
                            });
                            print(e);
                            StatusSnackbar.showError(context, e.toString());
                          }

                        }else{
                          if(context.mounted){
                            StatusSnackbar.showError(context, "Add items to the cart for you to place an order");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffc11e2c),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                      ),
                      child: loading? loadingAnimation : text
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ],
            )
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: bar,
      body: window,
    );
  }
}
