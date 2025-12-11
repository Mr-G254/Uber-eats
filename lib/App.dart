import 'package:flutter/cupertino.dart';
import 'package:uber_eats/MealData.dart';

abstract class App{
  static ValueNotifier<List<MealData>> selectedMeal = ValueNotifier([]);
  static ValueNotifier<int> totalPrice = ValueNotifier(0);

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

      MealData matchMeal = MealData(name: selected[index].name, price: selected[index].price, image_Link: selected[index].image_Link,quantity: selected[index].quantity + 1);
      selected.removeAt(index);
      selected.add(matchMeal);

    }else{
      selected.add(MealData(name: meal.name, price: meal.price, image_Link: meal.image_Link,quantity: 1));
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