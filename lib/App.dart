import 'package:flutter/cupertino.dart';
import 'package:uber_eats/MealData.dart';

abstract class App{
  static ValueNotifier<List<MealData>> selectedMeal = ValueNotifier([]);

  static void addMeal(MealData meal){
    var selected = selectedMeal.value;
    Iterable<MealData> match = selected.where((data) => data.name == meal.name);

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
      selected.add(meal);
    }
    selectedMeal.value = selected;

  }


}