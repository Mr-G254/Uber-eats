import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uber_eats/MealData.dart';

import '../Components.dart';

abstract class App{
  static ValueNotifier<List<MealData>> selectedMeal = ValueNotifier([]);
  static ValueNotifier<int> totalPrice = ValueNotifier(0);


  static String serverUrl = 'http://192.168.1.100:8080';
  static String currentErrorMessage = "";

  static String userName = "";
  static late Map<String,String> userData;
  static List<Map<String,String>> userOrders = [];

  static List<Meal> meals = [];

  static Future<bool> createUser(String fullName, String email, String password)async{

    var response = await http.post(
        Uri.http(serverUrl,"/users/signup"),
        body: {
          {
            "email": email,
            "password": password,
            "name": fullName,
          }
        }
    );

    if(response.statusCode == 201){
      userData = jsonDecode(response.body)["data"];

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

      return false;
    }
  }

  static Future<bool> login(String email, String password)async{
    var response = await http.post(
      Uri.http(serverUrl,"/users/login"),
      body: {
        {
          "email": email,
          "password": password,
        }
      }
    );

    if(response.statusCode == 200){
      userData = jsonDecode(response.body)["data"];

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

      return false;
    }
  }

  static Future<void> getMenu()async{
    var response = await http.get(Uri.http(serverUrl,"/restaurants/{restaurantId}/menu"));

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      List<Meal> widgets = [];

      for(final i in result){
        widgets.add(Meal(meal: MealData(name: i["name"], price: i["price"], image_Link: i["image"], id: i["id"])));

      }

      meals = widgets;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

    }
  }

  static Future<bool> orderFood()async{
    List<Map<String,int>> orders = [];

    for(final i in selectedMeal.value){
      orders.add(
        {
          "menuItemId": i.id,
          "quantity": i.quantity
        }
      );
    }

    var response = await http.post(
      Uri.http(serverUrl,"/restaurants/{restaurantId}/order"),
      body: {
        {
          "customerName": userData["name"],
          "customerEmail": userData["email"],
          "items": orders
        }
      }
    );

    if(response.statusCode == 200){
      userOrders.add(jsonDecode(response.body));
      selectedMeal.value = [];

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

      return false;
    }
  }

  /* UI Changes */

  static void addMeal(MealData meal){
    var selected = List<MealData>.from(selectedMeal.value);
    List<MealData> match = selected.where((data) => data.name == meal.name).toList();

    if(match.isNotEmpty){
      int index = 0;

      for(final i in selected){
        if(i.name == meal.name){
          break;
        }

        index = index + 1;
      }

      MealData matchMeal = MealData(name: selected[index].name, price: selected[index].price, image_Link: selected[index].image_Link,quantity: selected[index].quantity + 1, id: selected[index].id);
      selected.removeAt(index);
      selected.add(matchMeal);

    }else{
      selected.add(MealData(name: meal.name, price: meal.price, image_Link: meal.image_Link,quantity: 1, id: meal.id));
    }
    selectedMeal.value = selected;
    getTotalPrice();

  }

  static void incrementMeal(MealData meal){
    var selected = List<MealData>.from(selectedMeal.value);
    selected.removeWhere((val) => val.name == meal.name);

    if(meal.quantity > 0){
      selected.add(meal);
    }

    selectedMeal.value = selected;
    getTotalPrice();
  }

  static void getTotalPrice(){
    int total = 0;

    for(final i in selectedMeal.value){
      total = total + (i.price * i.quantity);
    }

    totalPrice.value = total;
  }

}