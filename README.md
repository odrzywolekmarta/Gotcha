![IMG_2841](https://user-images.githubusercontent.com/104859883/212072094-7503a644-e738-47ec-8adb-1e5c4ab3ba53.JPG)
# GOTCHA
> Gotcha is a Pokédex app created display information about Pokémon.
## Table of Contents
* [App Preview](#app-preview)
* [General Info](#general-information)
* [Code Architecture](#code-architecture)
* [Screenshots](#screenshots)
* [Technologies Used](#technologies-used)
* [Resources](#resources)
## App Preview
![mockup-featuring-two-iphones-x-floating-against-a-solid-color-background-28764-2](https://user-images.githubusercontent.com/104859883/212097347-66f473e3-1018-4f3b-b907-b4fd18819dec.png)
## General Information
- This 3-screen application presents basic information and statistics about Pokémon.
- Gocha app was developed solely for educational purposes.
## Code Architecture
- MVVM pattern and dependency injection were used for testability and better separation of business logic from UI code. 
- For navigation, the app uses AppRouter class so that view controllers aren't responsible for presenting subsequent view controllers, but delegate it to the proper AppRouter instance (each tab has its own navigation controller and AppRouter instance).
## Screenshots
<img src="https://user-images.githubusercontent.com/104859883/212106891-77cacde9-ddb6-47fa-b584-21c0614fb2b1.gif" width=24% height=24%> <img src="https://user-images.githubusercontent.com/104859883/212148809-addad3df-a44a-488b-a625-661245b9cdb2.gif" width=24% height=24%> <img src="https://user-images.githubusercontent.com/104859883/212147330-fb03ab9a-976d-489e-95c0-65050a00f6c8.gif" width=24% height=24%> <img src="https://user-images.githubusercontent.com/104859883/212151257-882dbca2-6908-471a-b003-979637c64aa7.gif" width=24% height=24%>
<img src="https://user-images.githubusercontent.com/104859883/212155316-3c09a11c-d94a-4e37-bbd1-c30288357dcd.gif" width=24% height=24%>
## Technologies Used
## Resources
