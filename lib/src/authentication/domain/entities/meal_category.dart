import 'package:equatable/equatable.dart';

class MealCategory extends Equatable{

  const MealCategory({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription});

  const MealCategory.fake() : this(
    idCategory: '1',
    strCategory: 'Chicken',
    strCategoryThumb: "https://www.themealdb.com/images/category/chicken.png",
    strCategoryDescription: 'Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.'
  );

  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  @override
  List<Object?> get props => [idCategory,strCategory,strCategoryThumb,strCategoryDescription];

}
