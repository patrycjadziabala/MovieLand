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
![3](https://user-images.githubusercontent.com/124930897/236706953-8352b11c-4809-4c69-ac19-485060afbcf4.gif)
![4](https://user-images.githubusercontent.com/124930897/236706954-b6a70cf0-4859-4c04-9819-2422275e012e.gif)
![5](https://user-images.githubusercontent.com/124930897/236706956-02c196aa-d66b-4605-898a-f80710bd27bc.gif)
![6](https://user-images.githubusercontent.com/124930897/236706959-43683c30-c2da-4b09-9115-7027dc55cf05.gif)
![7](https://user-images.githubusercontent.com/124930897/236706960-b118072d-6f2a-4bfb-a2c8-d79a5d9e35dc.gif)

![8](https://user-images.githubusercontent.com/124930897/236706961-e96ece76-1a3c-46cd-8999-614ad1ec8cbf.gif)
![9](https://user-images.githubusercontent.com/124930897/236706962-0dcef8f3-a454-40fd-be66-c32f361fe64d.gif)
![10](https://user-images.githubusercontent.com/124930897/236706964-ad4eb4dd-0f9b-481d-89fb-df055ad79af5.gif)
![11](https://user-images.githubusercontent.com/124930897/236706968-9258b884-43ed-444e-9ac8-bd622ed564ad.gif)
![12](https://user-images.githubusercontent.com/124930897/236706970-53119270-fd4c-48f0-8240-6eaba2f6e6f9.gif)

## External Libraries
   * [SDWebImage](https://github.com/SDWebImage/SDWebImage)
## Resources
   * [IMDb API](https://imdb-api.com/api)
