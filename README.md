# MyMoviesApp

## Description ##

- Login Screen: The first screen would be a Login screen with an email and password field.
- Home Screen: Once the user is authenticated, the next screen would be the Home screen. This screen will have a top bar with a search textbox and button/icon. Then in the main body a list of Current Popular Movies are displayed
- Search Screen: The user will enter a search query for a movie name at the top search Textbox and button/icon. A new screen opens and do a lookup in the api for all movies (not just popular movies) that have that query string in their name and show the list of movies.

### App Demo ###

See the app live in the following video. Login, Top Movies and Search Option.

<img src="/demoImages/demoVideo_compressed.gif" width="40%">


## Requirements ##

- Open the config.dart file in lib folder
- Add your TMDB api key

```
String getApiKey() {
  return 'YOUR_TMDB_API_KEY';
}
```


## How to run the application? ##

```
flutter run
```

## Previews ##

### Login Screen ###

| Login     | Invalid Login |
| ---      | ---       |
| <img src="/demoImages/LogIn_Page.jpg" width="100%" height="100%"> |<img src="/demoImages/LogIn_Invalid_Page.jpg" width="100%" height="100%">|

### Home Screen ###

<img src="/demoImages/Home_Page.jpg" width="50%" height="50%">

| Search Screen | Seach Keyboard |
| ---       | ---       |
|<img src="/demoImages/Home_Page_Search_1.jpg" width="100%" height="100%">|<img src="/demoImages/Home_Page_Search_2.jpg" width="100%" height="100%">|


### Search Screen ###

<img src="/demoImages/Search_Page.jpg" width="50%" height="50%">


## Background Credits ###

All Background images are from https://pixabay.com under Pixabay license. https://pixabay.com/service/license/
