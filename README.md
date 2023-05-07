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
![3](https://user-images.githubusercontent.com/124930897/236706320-28b67d24-6afa-4e58-84a9-ac7cd1af9745.gif)
![4](https://user-images.githubusercontent.com/124930897/236706540-500787cb-0f6b-4405-b503-bc741fd74771.gif)
![5](https://user-images.githubusercontent.com/124930897/236706541-c9ff11dd-a120-478d-965f-ca9b57fc7d4e.gif)
![6](https://user-images.githubusercontent.com/124930897/236706543-b6ed939c-dd57-40fd-90ca-154207ad6696.gif)
![7](https://user-images.githubusercontent.com/124930897/236706544-e5ed8c94-baea-4b52-af7a-2e3f03b53973.gif)
![8](https://user-images.githubusercontent.com/124930897/236706545-5ca9b3ba-5981-4d1e-8f44-c764e759f40d.gif)
![9](https://user-images.githubusercontent.com/124930897/236706547-f0ec0b90-2f58-411b-8e09-5741f9353487.gif)
![10](https://user-images.githubusercontent.com/124930897/236706548-12213abb-929c-4709-9d88-02026fd8f409.gif)
![11](https://user-images.githubusercontent.com/124930897/236706549-294a4993-1756-414a-8190-6f1f6e406f85.gif)
![12](https://user-images.githubusercontent.com/124930897/236706552-07b05f34-50f5-4401-842d-cd141353ef62.gif)

## External Libraries
   * [SDWebImage](https://github.com/SDWebImage/SDWebImage)
## Resources
   * [IMDb API](https://imdb-api.com/api)
