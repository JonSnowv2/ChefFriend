# CHEF'S FRIEND
#### Video Demo:  <https://www.youtube.com/watch?v=x3ClvhyVKX4>
#### Description: Website where users can store their favorite recipes in detail, but also share their recipes with the world if they want to - the public recipes can be viewed by anyone using the site (so you can also use it to discover new recipes)

## FRONTEND

The frontend of webiste is made using [Flutter](https://flutter.dev/).

All the code was done in the "lib" folder. <br>
**All other files and folders are not created by me, but are necessary files that are automatically created when starting a new flutter project to ensure it works properly**
<br>
I have chosen the specific Blue and Orange palette since I thought it resembled the paltform's purpose well.

Starting with the **main** file we have the runApp, which runs the website.

```
runApp(
    OverlaySupport(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: White_Anti_Flash),
        routeInformationParser: myAppRouter.router.routeInformationParser,
        routerDelegate: myAppRouter.router.routerDelegate,
        routeInformationProvider: myAppRouter.router.routeInformationProvider,
      ),
    ),
  );
```

The OverlaySupport is needed so I can display PopUp alert messages while using the app like "Log In Successfull". <br>
The theme makes it so all widgets that do not explicitly state what their color are set to that specific color, in this case it is *White_Anti_Flash*, hex code `0xEFEFEF` <br>
The next three are related to routing and are essential for the site to work properly. I used [GoRouter](https://pub.dev/packages/go_router) for Navigation between pages.<br>
<br>

**GoRouter**. This is how I used it:

```
class MyAppRouter{

  GoRouter router = GoRouter(

    routes: [
      GoRoute(
          name: MyAppRouteConstants.defaultRouteName,
          path: '/',
          pageBuilder: (context, state){
            return MaterialPage(child: WelcomePage());
          }
      ),
      GoRoute(
        name: MyAppRouteConstants.registerRouteName,
        path: '/register',
        pageBuilder: (context, state){
          return MaterialPage(child: RegisterPage());
        }
      ),
      GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: '/login',
          pageBuilder: (context, state){
            return MaterialPage(child: LogInPage());
          }
      ),
      GoRoute(
          name: MyAppRouteConstants.appRouteName,
          path: '/chefs_friend',
          pageBuilder: (context, state){
            return MaterialPage(child: HomePage());
          }
      ),
    ],
    errorPageBuilder: (context, state){
      return MaterialPage(child: UnknownPage());
    }

  );
}

class MyAppRouteConstants{
  static const String defaultRouteName = 'default';
  static const String registerRouteName = 'register';
  static const String loginRouteName = 'login';
  static const String appRouteName = 'chefs_friend';
}
```

It basically just is a collection of GoRoute, which have a name, a path, and a pageBuilder, in which you put the page that you want to be built when the path is accessed.<br>
Below I've used `MyAppRouteConstants`, to create the names for every path, in order to make Navigation easier - I would go to pages by using `goNamed(route_name)` rather than the using the route_path.
<br>
<br>

Inside the **Styles** directory I've created files such as Colors (I've initialized Colors var, Shadows var and Gradients var) in order to use make using the same design on multiple widgets easier.
<br>
<br>

Inside the **Classes** directory I've created 2 classes - `User` and `Recipe` - to create objects, in order to help me structure my information more clearly and help me decode JSON files coming from backend faster and easier.<br>
Each object has attributes (variables) that are protected and all of them have getters and setters.
<br>
<br>

Then, there is the **Service**, which handles the connection with the backend, is made out of all [asynchronous](https://dart.dev/codelabs/async-await) functions. <br>
This directory which has three files: one of them handles the [GoRouter](https://pub.dev/packages/go_router) I've mentioned before. The two other `recipe_service.dart` - which handles creating, deleting and editing recipes in frontend, transmitting the data to the backend - and `user_service` - which handles the register process, the log in process, and favorites mainly.
<br>
The site used *token-based authentication*.
<br>
<br>

Finally, you have the `Widgets` directory, in which I created, custom, smaller Widgets that are used on the main pages.<br>
One example could be the `CoolTextBar` which is a widget I use in register, login and when creating a recipe. It looks like this:
```
class CoolTextBar extends StatefulWidget {
  TextEditingController Controller;
  String type;
  final FormFieldValidator<String>? validator;

  CoolTextBar({super.key, required this.Controller, required this.type, required this.validator});

  @override
  State<CoolTextBar> createState() => _CoolTextBarState();
}

class _CoolTextBarState extends State<CoolTextBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          labelText: widget.type,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          hintText: '...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.blue)
          )
      ),
      controller: widget.Controller,
      validator: widget.validator,
    );
  }
}
```
You'll see it in multiple files, called as **CoolTextBar(*with the 3 parameters*)**
<br>
<br>

The other files are the **main** pages of the site

* Profile Page
* HomePage (That has the [TabBar](https://docs.flutter.dev/cookbook/design/tabs) navigation)
* Create Recipe Page
* Public Recipes Page
* Favorites Page
* Welcome Page
* Register Page
* Log In Page
<br>
<br>

### That was it for the frontend!

## Be sure to check the backend for this website - [Backend](https://github.com/JonSnowv2/ChefFriend-BE)!













