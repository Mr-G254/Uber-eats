import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uber_eats/MealData.dart';

import '../Components.dart';

abstract class App{
  static ValueNotifier<List<MealData>> selectedMeal = ValueNotifier([]);
  static ValueNotifier<double> totalPrice = ValueNotifier(0);

  static String baseUrl = "https://c3992bbd026b.ngrok-free.app";
  static String serverUrl = '$baseUrl/api';
  static String currentErrorMessage = "";

  static String userName = "";
  static late Map<String,dynamic> userData;
  static List<Map<String,dynamic>> userOrders = [];

  static List<Meal> meals = [];

  static Future<bool> createUser(String fullName, String email, String password)async{

    var response = await http.post(
      Uri.parse("$serverUrl/users/signup"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "name": fullName,
        // "phone number": "012938347"
      })
    );

    if(response.statusCode == 201){
      userData = jsonDecode(response.body)["data"];
      print(userData);

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];
      print(currentErrorMessage);

      return false;
    }
  }

  static Future<bool> login(String email, String password)async{
    var response = await http.post(
      Uri.parse("$serverUrl/users/login"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      })
    );

    if(response.statusCode == 200){
      userData = jsonDecode(response.body)["data"];
      print(userData);

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

      return false;
    }
  }

  static Future<bool> getMenu()async{
    var response = await http.get(Uri.parse("$serverUrl/restaurants/1/menu"));

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      List<Meal> widgets = [];
      print(result);

      for(final i in result){
        widgets.add(Meal(meal: MealData(name: i["name"], price: i["price"], image_Link: i["imageUrl"], id: i["id"])));


      }

      meals = widgets;

      return true;
    }else{
      currentErrorMessage = jsonDecode(response.body)["message"];

      return false;
    }
  }

  static Future<bool> orderFood()async{
    List<Map<String,dynamic>> orders = [];

    for(final i in selectedMeal.value){
      orders.add(
        {
          "menuItemId": i.id,
          "quantity": i.quantity
        }
      );
    }

    var response = await http.post(
      Uri.parse("$serverUrl/restaurants/1/order"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      },
      body: jsonEncode({
        "customerName": userData["name"],
        "customerEmail": userData["email"],
        "items": orders
      })
    );

    if(response.statusCode == 200){
      userOrders.add(jsonDecode(response.body)["Orderitems"]);
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
    double total = 0;

    for(final i in selectedMeal.value){
      total = total + (i.price * i.quantity);
    }

    totalPrice.value = total;
  }

}