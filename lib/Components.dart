import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:uber_eats/MealData.dart';
import 'Backend/App.dart';

class Input extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? type;
  final bool? enabled;

  const Input({super.key, required this.label, required this.controller, this.type = TextInputType.text,this.enabled = true});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool visible = true;

  @override
  void initState() {
    super.initState();

    if (widget.type == TextInputType.visiblePassword) {
      setState(() {
        visible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final input = Container(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(0),
            height: 45,
            child: TextField(
              controller: widget.controller,
              cursorColor: Colors.black,
              obscureText: !visible,
              enabled: widget.enabled,
              style: TextStyle(
                  height: 1,
                  fontSize: 14,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                  suffixIcon: Visibility(
                    visible: widget.type == TextInputType.visiblePassword,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(11),
                        child: Image(
                          image: AssetImage(visible == true
                              ? "Icons/not_visible.png"
                              : "Icons/visible.png"
                          ),
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.black
                      )
                   ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.black
                      )
                  )
              ),
            ),
          )
        ],
      ),
    );

    return input;
  }
}


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

class CartMeal extends StatefulWidget{
  final MealData meal;
  const CartMeal({super.key,required this.meal});

  @override
  State<CartMeal> createState() => _CartMealState();
}

class _CartMealState extends State<CartMeal>{
  int mealCount = 0;

  @override
  void initState() {
    super.initState();

    mealCount = widget.meal.quantity;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 0,
            color: Color(0xffc1bfbf),
            child: Image(
              image: AssetImage(widget.meal.image_Link),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.meal.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1,
                    fontFamily: "Times",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black
                  ),
                ),
                Text(
                  "KES ${widget.meal.price.toString()}",
                  style: TextStyle(
                    fontFamily: "Times",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff11bd83)
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 40,
            padding: EdgeInsets.only(right: 10,left: 10),
            child: CartStepperInt(
              alwaysExpanded: true,
              size: 30,
              value: mealCount,
              didChangeCount: (int value) {
                setState(() {
                  mealCount = value;
                });

                App.incrementMeal(MealData(id: widget.meal.id, name: widget.meal.name, price: widget.meal.price, image_Link: widget.meal.image_Link,quantity: value));
              },
              style: CartStepperStyle(
                radius: Radius.circular(4),
                //
              ),
            ),
          )
        ],
      ),
    );
  }
}