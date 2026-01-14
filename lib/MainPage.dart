import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:status_snackbar/status_snackbar.dart';
import 'package:uber_eats/Components.dart';
import 'package:uber_eats/MealData.dart';
import 'package:uber_eats/OrderPage.dart';

import 'Backend/App.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin{

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

    final shimmerAnimation = Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Shimmer(
              duration: Duration(seconds: 2),
              colorOpacity: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffc1bfbf),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Shimmer(
              duration: Duration(seconds: 2),
              colorOpacity: 0.9,
              child: Container(
                margin: EdgeInsets.only(top: 10,bottom: 0),
                decoration: BoxDecoration(
                  color: Color(0xffc1bfbf),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(7)
                ),
              ),
            )
          )
        ],
      ),
    );

    final window  = Column(
      children: [
        bar,
        // SizedBox(height: 0,),
        // searchbar,
        SizedBox(height: 10,),
        Expanded(
          child: FutureBuilder(
            future: App.getMenu(),
            builder: (context,snapshot){
             if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting){
                return GridView.extent(
                  mainAxisSpacing: 0,
                  padding: EdgeInsets.only(bottom: 10),
                  shrinkWrap: false,
                  childAspectRatio: 5/6,
                  maxCrossAxisExtent: 200,
                  children: [
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                    shimmerAnimation,
                  ],
                );

             } else if(snapshot.connectionState == ConnectionState.done){
               if(snapshot.hasError){
                 print(snapshot.error.toString());
                 // StatusSnackbar.showError(context, snapshot.error.toString());

                 return GridView.extent(
                   mainAxisSpacing: 0,
                   padding: EdgeInsets.only(bottom: 10),
                   shrinkWrap: false,
                   childAspectRatio: 5/6,
                   maxCrossAxisExtent: 200,
                   children: [
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                     shimmerAnimation,
                   ],
                 );
               }else {
                 if(snapshot.data == true){
                   return GridView.extent(
                     mainAxisSpacing: 0,
                     padding: EdgeInsets.only(bottom: 10),
                     shrinkWrap: false,
                     childAspectRatio: 5 / 6,
                     maxCrossAxisExtent: 200,
                     children: App.meals
                   );
                 }else{
                   StatusSnackbar.showError(context, App.currentErrorMessage);
                   return SizedBox();
                 }

               }
             }else{
                StatusSnackbar.showError(context, App.currentErrorMessage);
                print(snapshot.error);
                return SizedBox();
             }
            }
          ),
        ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}