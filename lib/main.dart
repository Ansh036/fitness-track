import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Fitness(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Fitness extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Fitness> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Lottie.asset(
          'assets/Animation - 1739956849705.json',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _steps = 0;
  final List<String> workoutCategories = [
    'Shoulder',
    'Back',
    'Legs',
    'Chest',
    'Arms',
    'Abs',
    'Yoga',
  ];
  final Map<String, String> categoryAnimations = {
    'Shoulder': 'assets/Animation - 1739953204216.json',
    'Back': 'assets/Animation - 1739953517263.json',
    'Legs': 'assets/Animation - 1739878274129.json',
    'Chest': 'assets/Animation - 1739878793711.json',
    'Arms': 'assets/Animation - 1739953553213.json',
    'Abs': 'assets/Animation - 1739955883003.json',
    'Yoga': 'assets/Animation - 1739953623843.json',
  };

  @override
  void initState() {
    super.initState();
    _initStepCounter();
  }

  Future<void> _initStepCounter() async {
    if (await Permission.activityRecognition.request().isGranted) {
      Pedometer.stepCountStream.listen((StepCount event) {
        setState(() {
          _steps = event.steps;
        });
      });
    } else {
      print("Permission Denied");
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchDialog(workoutCategories: workoutCategories);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Fit Track', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _showSearchDialog,
            ),
          ],
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://pics.craiyon.com/2023-06-30/f0da51e5f5b748b688bd150d331b191f.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Image.network(
                      'https://cdn0.iconfinder.com/data/icons/gadget-52/64/fitness-tracker-health-monitor-device-1024.png',
                      width: 120,
                      height: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fit Track ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.grey),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.emoji_food_beverage_outlined, color: Colors.black),
                title: Text('Diet plan'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DietPlanHome()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.black),
                title: Text('Setting'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_box_outlined, color: Colors.black),
                title: Text('About'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text('Logout'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://pics.craiyon.com/2023-06-30/f0da51e5f5b748b688bd150d331b191f.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Divider(height: 5, color: Colors.grey),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Workouts',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: workoutCategories.length,
                        itemBuilder: (context, index) {
                          String category = workoutCategories[index];
                          return CategoriesCard(
                            title: category,
                            animationPath: categoryAnimations[category] ?? 'assets/animations/default.json',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                switch (category) {
                                  case 'Shoulder':
                                    return ShoulderScreen();
                                  case 'Back':
                                    return BackScreen();
                                  case 'Legs':
                                    return LegScreen();
                                  case 'Chest':
                                    return ChestScreen();
                                  case 'Arms':
                                    return BicepTricepScreen();
                                  case 'Abs':
                                    return AbsScreen();
                                  case 'Yoga':
                                    return YogaScreen();
                                  default:
                                    return HomeScreen();
                                }
                              }));
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(height: 5, color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: StepCounterCard(steps: _steps),
                  ),
                  Divider(height: 5, color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: StopwatchApp(),
                  ),
                  Divider(height: 5, color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: WaterIntakeCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SearchDialog extends StatefulWidget {
  final List<String> workoutCategories;
  SearchDialog({required this.workoutCategories});

  @override
  _SearchDialogState createState() => _SearchDialogState();
}
class _SearchDialogState extends State<SearchDialog> {
  List<String> filteredCategories = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    filteredCategories = widget.workoutCategories;
  }

  void _filterCategories(String query) {
    setState(() {
      searchTerm = query;
      filteredCategories = widget.workoutCategories
          .where((category) => category.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text("Search",style: TextStyle(color: Colors.white),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: _filterCategories,
            decoration: InputDecoration(hintText: "Search here",fillColor: Colors.white,filled: true,hintStyle: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredCategories[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      switch (filteredCategories[index]) {
                        case 'Shoulder':
                          return ShoulderScreen();
                        case 'Back':
                          return BackScreen();
                        case 'Legs':
                          return LegScreen();
                        case 'Chest':
                          return ChestScreen();
                        case 'Arms':
                          return BicepTricepScreen();
                        case 'Abs':
                          return AbsScreen();
                        case 'Yoga':
                          return YogaScreen();
                        default:
                          return HomeScreen(); // Fallback
                      }
                    }));
                  },
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Close",style: TextStyle(color:Colors.green),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
class Meal {
  final String name;
  final String description;
  final int calories;
  final String imageUrl;

  Meal({
    required this.name,
    required this.description,
    required this.calories,
    required this.imageUrl,
  });
}

class DietPlanHome extends StatelessWidget {
  final List<Meal> breakfastMeals = [
    Meal(
      name: "Mixed Vegetable Omelette",
      description: "INGREDIENTS :-\n 2 organic free range eggs\n4 small button mushrooms\nHandful of fresh spinach chopped\n1 small chopped tomato\n1/2 finely chopped onion\n1 finely chopped clove of garlic\n1 tsp extra virgin coconut oil\n1/2 tsp paprika powder\n1/2 tsp mixed dried Italian herbs\npink Himalayan salt and ground pepper to taste",
      calories: 300,
      imageUrl: "https://i.ytimg.com/vi/LVeCsP5YoX8/maxresdefault.jpg",
    ),
    Meal(
      name: "Avocado Toast",
      description: "INGREDIENTS :-\n1 slice Sourdough bread\n1 cup canned garbanzo beans\n1 Tomato\n1/2 Avocado\n1/2 cup shallots\n1/2 cup cilantro\n1/2 cup parsley\n2 cloves garlic\n1/4 tsp olive oil\n1/4 tsp cumin\n1/4 tsp red pepper\n1/4 tsp black pepper\n\n1/2 tsp salt\n1 TBSP lemon",
      calories: 350,
      imageUrl: "https://cdn.prod.website-files.com/6682ad647d71ff9a4ed5a566/6682ad647d71ff9a4ed5b144_Garbanzo%20Avocado%20Toast.jpg",
    ),
    Meal(
      name: "Oatsmeal",
      description: "INGREDIENTS :-\n1 cup water or low-fat milk\nPinch of salt\n½ cup rolled oats\n2 tablespoons low-fat milk for serving\n1 to 2 teaspoons honey, cane sugar or brown sugar for serving\nPinch of cinnamon",
      calories: 250,
      imageUrl: "https://www.veggiesdontbite.com/wp-content/uploads/2020/04/vegan-oatmeal-recipe-FI.jpg",
    ),
    Meal(
      name: "Smoothie Bowl",
      description: "INGREDIENTS :-\nSMOOTHIE BOWL\n1 heaping cup organic frozen mixed berries\n1 small ripe banana (sliced and frozen)\n2-3 Tbsp light coconut or almond milk (plus more as needed)\n1 scoop plain or vanilla protein powder of choice* (optional)\nTOPPINGS optional\n1 Tbsp shredded unsweetened coconut (desiccated)\n1 Tbsp chia seeds\n1 Tbsp hemp seeds\nGranola\nFruit",
      calories: 300,
      imageUrl: "https://minimalistbaker.com/wp-content/uploads/2016/07/How-to-make-the-PERFECT-Smoothie-Bowl-Simple-ingredients-naturally-sweet-SO-healthy-vegan-glutenfree-smoothiebowl-recipe-breakfast.jpg",
    ),
    Meal(
      name: "Greek Yogurt Parfait",
      description: "INGREDIENTS :-\nStart by adding 1 to 2 big spoonfuls of yogurt in the bottom of each glass.\n1⅓ cups Greek yogurt\nAdd a spoonful of fresh fruit, a spoonful of granola and around a teaspoon of honey on top.\n1½ cups fresh fruit,1 cup granola,¼ cup honey\nSpoon the rest of the yogurt on top. Then finish with a final layer of the chopped fruit, granola and honey.\nEnjoy immediately, or cover with plastic wrap and keep in the fridge for up to 3 days. If making ahead, only add the top layer of granola just before serving.",
      calories: 200,
      imageUrl: "https://scrummylane.com/wp-content/uploads/2024/07/Greek-yogurt-parfaits-3.jpg",
    ),
  ];

  final List<Meal> lunchMeals = [
    Meal(
      name: "Egg Salad Sandwich",
      description: "INGREDIENTS :-\n8 large eggs\n½ cup mayonnaise,\n¼ cup chopped green onion,\n1 teaspoon prepared yellow mustard,\n¼ teaspoon paprika,\nsalt and pepper to taste",
      calories: 180,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRx3y7g5Ortls1LEmVYPibU5lj4C7u3jqaaFQ&s",
    ),
    Meal(
      name: "Chicken Shawarma Sheet-Pan Dinner",
      description: "INGREDIENTS :-\n1 cup plain Greek yogurt,\n2 teaspoons cumin, \n2 teaspoons cardamom,\n2 teaspoons tumeric,\n2 teaspoons cinnamon,\n2 teaspoons salt,\n3 large boneless, skinless chicken breast, sliced into 1inch strips,\n2 tablespoons Extra Virgin Olive Oil,\n2 large red bell peppers, cut into, \n1/2-inch thin strips,\n1 purple onion, cut into, \n1/2-inch thin slices,\n½ cup peppadew peppers",
      calories: 250,
      imageUrl: 'https://hips.hearstapps.com/hmg-prod/images/del019925-chicken-shawarma-sheet-pan-dinner-web-0292-rl-vertical-67a3fab327ba8.jpg?crop=0.774xw:0.928xh;0.0918xw,0.00136xh&resize=980:*',
    ),
    Meal(
      name: "Tofu Nuggets",
      description: "INGREDIENTS :-\n2Tbsp. extra-virgin olive oil, divided, plus more for pan,\n 2Tbsp. all-purpose flour or rice flour, \n2Tbsp. cornstarch or potato starch,\n 2Tbsp. nutritional yeast,\n1Tbsp. garlic powder,\n 1Tbsp. onion powder,\n 1½tsp. Diamond Crystal or ¾ tsp. Morton kosher salt, plus more,\n 14–16 oz. block firm tofu, drained",
      calories: 190,
      imageUrl: "https://hips.hearstapps.com/hmg-prod/images/tofu-nuggets-vertical-2-6787f582499eb.jpg?crop=0.8335104498760184xw:1xh;center,top&resize=980:*",
    ),
    Meal(
      name: "Creamy Peanut-Lime Chicken With Noodles",
      description: "INGREDIENTS :-\nKosher salt\n8 oz. thick rice noodles,\n1/2 cup no-sugar-added creamy peanut butter,\n3 Tbsp. sweet chili sauce",
      calories: 300,
      imageUrl: 'https://hips.hearstapps.com/hmg-prod/images/creamy-peanut-lime-chicken-noodles-lead-6596d2ac18b37.jpg?crop=0.6666666666666666xw:1xh;center,top&resize=980:*',
    ),
    Meal(
      name: "Tofu Burritos",
      description: "INGREDIENTS :-\n340 gram tofu, 1 block, cut into 1-inch chunks\n½ tsp cumin,\n½ tsp garlic powder,\n1 tsp paprika,\n 1 tbsp hoisin sauce,\n½ tsp sea salt,\n2 handfuls spinach,\n½ cup cherry tomatoes, diced,\n½ red onion, diced,\n¾ cup vegan yogurt, unsweetened,\n 4 tbsp hot sauce,\n½ tsp garlic powder,\n1 tsp italian seasoning,\n 2 whole grain tortillas,\n ½ cup Brown rice, cooked",
      calories: 150,
      imageUrl: 'https://d36fw6y2wq3bat.cloudfront.net/recipes/burritos-de-tofu/900/burritos-de-tofu_version_1682654429.jpg',
    ),
  ];

  final List<Meal> dinnerMeals = [
    Meal(
      name: "Shredded, Saucy BBQ Chicken Sammies",
      description: "A healthy serving of steamed vegetables with grilled fish.",
      calories: 400,
      imageUrl: "https://assets.surlatable.com/m/12a90375e3d0237b/72_dpi_webp-WolfgangPuck_SteamedWhiteFish.jpg",
    ),
    Meal(
      name: "Barbecue Chicken with Succotash",
      description: "Ingrediant:- \n4 skin-on, bone-in chicken breasts (about 2 pounds),\n Kosher salt and freshly ground pepper,\n1/2 cup apple cider,\n1/4 cup ketchup,\n2 tablespoons Worcestershire sauce,\n 1 tablespoon plus 1 teaspoon dijon mustard,\n 3 tablespoons unsalted butter,\n 1 bunch scallions, chopped (white and green parts separated),\n 1 bunch scallions, chopped (white and green parts separated),\n 1 red bell pepper, chopped,\n 1 10-ounce package frozen corn,\n1 10-ounce package frozen baby lima beans",
      calories: 450,
      imageUrl: "https://cookinglowkey.com/wp-content/uploads/2019/09/Grilled_Chicken.png",
    ),
    Meal(
      name: "Chickpea Curry",
      description: "Ingrediants :-\n 2 tbsp oil,\n1 onion diced,\n 1 tsp fresh or dried chilli to taste,\n 9 garlic cloves(approx 1 small bulb of garlic)thumb-sized piece gingerpeeled,\n 1 tbsp ground coriander,\n 2 tbsp ground cumin,\n 1 tbsp garam masala,\n 2 tbsp tomato puréeFor the curry,\n 2 x 400g cans chickpeasdrained,\n 400g can chopped tomatoes,\n 100g creamed coconut,½ small pack corianderchopped, plus extra to garnish,\n100g spinachTo servecooked riceand/or dahl,",
      calories: 500,
      imageUrl: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/kadala-curry-fad4df3.jpg?quality=90&webp=true&resize=375,341",
    ),
    Meal(name:"Beans, Greens and Cream", description:'Ingrediants :-\n3 tablespoons olive oil,\n2 cloves garlic, thinly sliced or pressed through a garlic press,\n1/2 teaspoon chili flakes, optional,\n 2 (14-ounce) cans white beans, drained and rinsed, liquid reserved\n4 packed cups baby spinach (about 3.5 ounces),\n1 teaspoon kosher salt,\n1/2 teaspoon freshly ground black pepper,\n1 to 2 tablespoons fresh lemon juice,\nGrated Parmesan cheese for serving, optional',
        calories: 190, imageUrl: "https://www.simplyrecipes.com/thmb/0xFhH-2DUd1AlsVypvQL91Ua8jU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/simply-recipes-white-beans-and-greens-lead-03-3f61fceba239464591dc60bbcc9a2a86.jpg"),
  ];

  final List<Meal> otherMeals = [
    Meal(
      name: "Greek Yogurt with Honey",
      description: " Ingrediants:- \n1 cup 170g Greek yogurt,\n2-3 tablespoons Greek honey or any one you prefer,\n 1 bowl to serve optional",
      calories: 150,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4f8iBv3ZRbDdY10QbcjwV5dYHZ1Ge4hes3A&s",
    ),
    Meal(
      name: "Chickpea Salad",
      description: "Ingrediants :- \n2 tablespoons extra-virgin olive oil,\n 2 tablespoons fresh lemon juice,\n 1 garlic clove, grated,\n 1 teaspoon Dijon mustard, \n 1 teaspoon sea salt,Freshly ground black pepper\n 3 cups cooked chickpeas, drained and rinsed,\n 2 cups mixed yellow and red grape tomatoes, halved½ English cucumber, diced½ cup Pickled Red Onions½ cup kalamata olives, pitted and halved½ cup chopped fresh parsley",
      calories: 300,
      imageUrl: "https://cdn.loveandlemons.com/wp-content/uploads/2023/05/chickpea-salad-846x846.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Plan",style: TextStyle(fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Breakfast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: breakfastMeals.length,
                  itemBuilder: (context, index) {
                    final meal = breakfastMeals[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(meal.name),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(meal.imageUrl),
                                    SizedBox(height: 10),
                                    Text(meal.description),
                                    SizedBox(height: 10),
                                    Text("${meal.calories} calories"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: MealCard(meal: meal),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Lunch Meals",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lunchMeals.length,
                  itemBuilder: (context, index) {
                    final meal = lunchMeals[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(meal.name),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(meal.imageUrl),
                                    SizedBox(height: 10),
                                    Text(meal.description),
                                    SizedBox(height: 10),
                                    Text("${meal.calories} calories"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: MealCard(meal: meal),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Dinner Meals",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight .bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dinnerMeals.length,
                  itemBuilder: (context, index) {
                    final meal = dinnerMeals[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text(meal.name),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(meal.imageUrl),
                                    SizedBox(height: 10),
                                    Text(meal.description),
                                    SizedBox(height: 10),
                                    Text("${meal.calories} calories"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: MealCard(meal: meal),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Other Meals",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: otherMeals.length,
                  itemBuilder: (context, index) {
                    final meal = otherMeals[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(meal.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(meal.imageUrl),
                                  SizedBox(height: 10),
                                  Text(meal.description),
                                  SizedBox(height: 10),
                                  Text("${meal.calories} calories"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: MealCard(meal: meal),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({Key? key, required this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      color: Colors.white,
      child: Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${meal.calories} calories",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Name: FitTrack',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'FitTrack is a comprehensive fitness tracking app designed to help you achieve your health and wellness goals. With features like workout logging, meal tracking, and progress monitoring, FitTrack empowers you to take control of your fitness journey.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'At FitTrack, our mission is to inspire and motivate individuals to lead healthier lives through innovative technology and community support.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'The Team:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Piyush Gill \nAnsh Garg',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'For questions or feedback, please reach out to us at fitTrack@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Follow Us:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Facebook | Twitter | Instagram',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Privacy Policy:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Read our Privacy Policy',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Terms of Service:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Read our Terms of Service',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class WaterIntakeCard extends StatefulWidget {
  @override
  _WaterIntakeCardState createState() => _WaterIntakeCardState();
}

class _WaterIntakeCardState extends State<WaterIntakeCard> {
  int waterIntake = 0;

  void increaseWater() {
    setState(() {
      waterIntake += 10;
    });
  }

  void decreaseWater() {
    setState(() {
      if (waterIntake >= 10) waterIntake -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined, size: 30, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "$waterIntake ml",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: increaseWater,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: Text("Increase", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: decreaseWater,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: Text("Decrease", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {});
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formattedTime() {
    final elapsed = _stopwatch.elapsed;
    return "${elapsed.inMinutes}:${elapsed.inSeconds.remainder(60).toString().padLeft(2, '0')}:${(elapsed.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formattedTime(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: Text("Start"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: Text("Stop"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class StepCounterCard extends StatelessWidget {
  final int steps;
  StepCounterCard({required this.steps});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.3), Colors.green.withOpacity(0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/Animation - 1740465321198.json',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 0),
                Text(
                  "Steps Taken",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 0),
                Text(
                  "$steps",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final String title;
  final String animationPath; // Path to JSON animation
  final VoidCallback onTap;

  CategoriesCard({
    required this.title,
    required this.animationPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                animationPath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ShoulderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WorkoutScreen(
      title: 'Shoulder Workout',
      exercises: [
        ExerciseCard(
          title: 'Overhead Press',
          description: 'A great exercise for overall shoulder strength.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Lateral Raise',
          description: 'Targets the side deltoids for width.',
          animationPath: 'assets/Animation - 1741082440943.json',
        ),
        ExerciseCard(
          title: 'Front Raise',
          description: 'Focuses on the front deltoids.',
          animationPath: 'assets/Animation - 1739878274129.json',
        ),
        ExerciseCard(
          title: 'Reverse Fly',
          description: 'Works the rear deltoids and upper back.',
          animationPath: 'assets/Animation - 1739878793711.json',
        ),
        ExerciseCard(
          title: 'Arnold Press',
          description: 'A variation of the overhead press that targets all three deltoid heads.',
          animationPath: 'assets/Animation - 1739953517263.json',
        ),
      ],),
    );
  }
}

class BackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WorkoutScreen(
      title: 'Back Workout',
      exercises: [
        ExerciseCard(
          title: 'One arm Dumbell row',
          description: 'Single arm rows work the back muscles.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Bent over row',
          description: 'The dumbbell should come right below your knees and from here you are going to pull drag the elbows up towards the ceiling and then bring it all the way back down.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Pull down',
          description: 'The pull-down exercise is a strength training exercise designed to develop the latissimus dorsi muscle',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Seated cable row',
          description: 'You should be sitting straight upright with your shoulders back.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Upper back stretch',
          description: 'You can strengthen your back with these exercises',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
      ],
    ),
    );
  }
}

class LegScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WorkoutScreen(
      title: 'Leg Workout',
      exercises: [
        ExerciseCard(
          title: 'Squat',
          description: 'A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.',
          animationPath: 'assets/Animation - 1741083656776.json',
        ),
        ExerciseCard(
          title: 'Deadlift',
          description: 'The deadlift is a strength training exercise in which a weight-loaded barbell is lifted off the ground to the level of the hips, with the torso perpendicular to the floor, before being placed back on the ground.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Bulgarian Split Squat',
          description: 'The Bulgarian split squat is another great exercise for leg day workouts.',
          animationPath: 'assets/man-lifting-barbell.json',),
        ExerciseCard(
          title: 'Leg Press',
          description: 'The leg press is a compound weight training exercise in which the individual pushes a weight or resistance away from them using their legs.',
          animationPath: 'assets/Animation - 1741083583182.json',
        ),
        ExerciseCard(
          title: 'Front Squat',
          description: 'Barbell Front Squat x 6-10 reps, 3 sets. In the squat rack, grip the bar outside of your shoulders. Walk your body under the bar with bent knees.',
          animationPath: 'assets/man-doing-barbell-lunges.json',
        ),
        ExerciseCard(
          title: 'Glute Bridge',
          description: 'Glute bridge is a posterior chain exercise and one of the best exercises for legs for those who are not comfortable doing a squat or lunge.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
      ],
    )
    );
  }
}

class ChestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WorkoutScreen(
        title: 'Chest Workout',
        exercises: [
          ExerciseCard(
            title: 'Bench Press',
            description: 'The bench press or chest press is a weight training exercise where a person presses a weight upwards while lying horizontally on a weight training bench.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Push-up',
            description: 'The push-up is a common calisthenics exercise beginning from the prone position.',
            animationPath: 'assets/Animation - 1741083305196.json',
          ),
          ExerciseCard(
            title: 'Incline chest press ',
            description: 'Dumbbell Chest Fly · Lie on a flat bench, gripping dumbbells in each hand.',
            animationPath: 'assets/man-doing-inclined-press.json',
          ),
          ExerciseCard(
            title: 'Dumbbell Chest Press',
            description: 'The dumbbell chest press is a chest exercise that involves lying on your back and pressing dumbbells upward.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Dumbbell Pullover',
            description: 'The dumbbell pullover is a weightlifting exercise that targets your pecs and lat muscles.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: "Dips",
            description: 'Cable Crossover. Usually performed in a gym due to the required equipment, a cable crossover supports chest muscle definition.',
            animationPath: 'assets/man-doing-dips.json',
          ),
        ],
      ),
    );
  }
}

class BicepTricepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WorkoutScreen(
      title: 'Biceps & Triceps Workout',
      exercises: [
        ExerciseCard(
          title: 'Hammer Curl',
          description: 'The hammer curl targets both the biceps brachii and brachialis, as well as the brachioradialis muscle on the forearm, for more overall thickness.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Concentration Curl',
          description: 'The concentration curl is all about feeling your biceps work. Lifting with one arm lets you concentrate on engaging your biceps one at a time.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Incline Dumbbell Curl',
          description: 'Incline Dumbbell Curl. This workout is a hardcore free-weight movement that stretches the biceps and activates stretch shortening cycle (SSC).',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Close Grip Bench Press',
          description: 'A close grip bench press is a variation of the standard bench press where the hands are positioned much closer together on the barbell.',
          animationPath: 'assets/Animation - 1739953204216.json',        ),
        ExerciseCard(
          title: 'Tricep Extension',
          description: 'A triceps extension is an exercise that strengthens the triceps muscles in the back of the upper arm.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Tricep Dips',
          description: 'The EZ bar is probably not the first piece of equipment you do go for if we asked you to do bicep curls.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
      ],
    ),
    );
  }
}

class AbsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WorkoutScreen(
      title: 'Abs Workout',
      exercises: [
        ExerciseCard(
          title: 'Russian Twist',
          description: 'The Russian twist is a simple abdominal exercise for working the core, shoulders, and hips.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Side Plank Leg Lift',
          description: 'Simultaneously lift your left arm and right leg off the floor. Straighten your leg and arm until they form a straight line, pointing in opposite directions.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Bicycle Crunch',
          description: 'Helps to reduce belly fat.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Cable Crunch',
          description: 'The cable crunch belongs in any bodybuilding abs workout.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Leg Raise',
          description: 'Leg raises are one of the best lower ab exercises, helping increase strength and muscular control throughout the core.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
        ExerciseCard(
          title: 'Flutter Kick',
          description: 'Flutter Kick. Best ab workout: Shirtless black man performs flutter kick.',
          animationPath: 'assets/Animation - 1739953204216.json',
        ),
      ],
    ),
    );
  }
}

class YogaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WorkoutScreen(
        title: 'Yoga',
        exercises: [
          ExerciseCard(
            title: 'Paschimottanasana ',
            description: 'The bench press or chest press is a weight training exercise where a person presses a weight upwards while lying horizontally on a weight training bench.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Veerabhadrasana',
            description: 'The push-up is a common calisthenics exercise beginning from the prone position.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Ardha Chakrasana ',
            description: 'Dumbbell Chest Fly · Lie on a flat bench, gripping dumbbells in each hand.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Hastapadasana',
            description: 'The dumbbell chest press is a chest exercise that involves lying on your back and pressing dumbbells upward.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Baddha Konasana ',
            description: 'The dumbbell pullover is a weightlifting exercise that targets your pecs and lat muscles.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
          ExerciseCard(
            title: 'Konasana',
            description: 'Cable Crossover. Usually performed in a gym due to the required equipment, a cable crossover supports chest muscle definition.',
            animationPath: 'assets/Animation - 1739953204216.json',
          ),
        ],
      ),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  final String title;
  final List<ExerciseCard> exercises;

  WorkoutScreen({required this.title, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title Routine',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: exercises,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ExerciseCard extends StatefulWidget {
  final String title;
  final String description;
  final String animationPath;

  ExerciseCard({
    required this.title,
    required this.description,
    required this.animationPath,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> with TickerProviderStateMixin {
  int _countdown = 3;
  late Timer _timer;
  int _selectedReps = 8;

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startCountdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            _countdown = 3;
            _timer = Timer.periodic(Duration(seconds: 1), (timer) {
              if (_countdown == 0) {
                _timer.cancel();
                Navigator.of(context).pop();
                _showExerciseDialog(context);
              } else {
                setState(() {
                  _countdown--;
                });
              }
            });

            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(widget.title, style: TextStyle(color: Colors.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$_countdown',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('Selected Reps: $_selectedReps', style: TextStyle(fontSize: 18)),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Close", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    _timer.cancel();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Start", style: TextStyle(color: Colors.green)),
                  onPressed: () {
                    _startCountdown(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showExerciseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(widget.title, style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                widget.animationPath,
                fit: BoxFit.cover,
                repeat: true,
              ),
              SizedBox(height: 10),
              Text(widget.description, style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Text('Reps: $_selectedReps', style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Stop", style: TextStyle(color: Colors.red)),
              onPressed: () {
                _timer.cancel();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startCountdown(context);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Lottie.asset(
                widget.animationPath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(widget.description, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    DropdownButton<int>(
                      value: _selectedReps,
                      items: [8, 10, 12].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedReps = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://pics.craiyon.com/2023-06-30/f0da51e5f5b748b688bd150d331b191f.webp',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    buildTextField(Icons.alternate_email, 'Email', emailController, false),
                    SizedBox(height: 10),
                    buildTextField(Icons.lock, 'Password', passwordController, true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if(userCredential != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Invalid username or password')),
                          );
                        }
                      },
                      style: buttonStyle(),
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: buttonStyle(),
                      child: Text('Create Account'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SignUpPage extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://pics.craiyon.com/2023-06-30/f0da51e5f5b748b688bd150d331b191f.webp',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    buildTextField(Icons.person, 'Full Name', fullNameController, false),
                    SizedBox(height: 10),
                    buildTextField(Icons.phone, 'Phone Number', phoneController, false),
                    SizedBox(height: 10),
                    buildTextField(Icons.alternate_email, 'Email', emailController, false),
                    SizedBox(height: 10),
                    buildTextField(Icons.lock, 'Password', passwordController, true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if( userCredential != null ) {
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen(),),
                            );
                          }
                          // Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error creating account')),
                          );
                        }
                      },
                      style: buttonStyle(),
                      child: Text('Sign Up'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget buildTextField(IconData icon, String hintText, TextEditingController controller, bool isObscure) {
  return Container(
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}