import 'package:equatable/equatable.dart';

class Meal extends Equatable{

  const Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal});

  const Meal.fake() : this(
    strMeal:  "Baked salmon with fennel & tomatoes",
    strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg",
    idMeal: "52959"
  );

  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  factory Meal.fromJson(Map<String, dynamic> json){ 
        return Meal(
            strMeal: json["strMeal"],
            strMealThumb: json["strMealThumb"],
            idMeal: json["idMeal"],
        );
    }

    Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
    };

  @override
  List<Object?> get props => [strMeal,strMealThumb,idMeal];

}
