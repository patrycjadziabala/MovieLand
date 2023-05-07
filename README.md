# MovieLand
MovieLand is an app created to display Actors and Movies information.
## Table Of Contents
## App Preview
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
