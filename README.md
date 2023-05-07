![IMG_3447_resized](https://user-images.githubusercontent.com/124930897/236702931-2230bd3b-81ef-4f0e-9b54-8943347dc771.jpg)

# MovieLand
MovieLand is an app created to display information about actors and movies.
## Table Of Contents
   - [App Preview](#app-preview)
   - [General Information](#general-information)
   - [Code Architecture](#code-architecture)
   - [Technologies Used](#technologies-used)
   - [Screenshots](#screenshots)
   - [External Libraries](#external-libraries)
   - [Resources](#resources)
## App Preview

![mockup-featuring-two-iphones-x-floating-against-a-solid-color-background-28764 copy 2](https://user-images.githubusercontent.com/124930897/236704056-7014d7f1-cdc5-4f29-96b2-415588784a6d.png)
## General Information
MovieLand is a multiple screen aplication which was created for educational purposes.
## Code Architecture
   * The goal of implementing the MVVM architectural pattern and dependency injection was to increase the degree of separation between the UI code and business logic and facilitate the testing process.
   * The application uses the AppRouter class for navigation purposes, so that view controllers are not burdened with the responsibility of presenting subsequent view controllers. Rather, the relevant AppRouter instance is delegated to handle the task, with each tab having its own navigation controller and AppRouter instance.
## Technologies Used
   * Swift
   * Swift Package Manager
   * UIKit
## Screenshots
## External Libraries
   * [SDWebImage](https://github.com/SDWebImage/SDWebImage)
## Resources
   * [IMDb API](https://imdb-api.com/api)
