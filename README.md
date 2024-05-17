# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Arhitecture](#arhitecture)
4. [Structure](#structure)
5. [Dependencies](#dependencies)
6. [Screenshots](#screenshots)

# IShowShop
IShowShop: Your Ultimate Shopping Companion!

# Description
<p>IShowShop is the revolutionary shopping app designed to bring the best of online experiences right to your fingertips. Whether you're searching for the latest trends, exclusive deals, or unique products, IShowShop has everything you need to shop smart, save big, and enjoy every moment of your shopping journey. Our features include: 

1. Searching products using **Microphone**
2. Wallet topup
3. Products fetching by most purchased and most favorite
4. Favorite products
5. Discount voucher with promo code **STEFANUSALBERT**


</p>

# Getting started
<p>
1. Open Xcode and make sure you have the Xcode version 15.3 or above installed on your computer.<br>
2. Clone the project from the repository and paste the link into the option "Clone Git Repository" in Xcode <br>
3. Navigate your cursor to Package Dependencies to see all of the installed dependencies<br>
4. Review the code and make sure you understand what it does.<br>
5. Run the active scheme.<br>
6. You should see the login view and feel free to create an account, if you haven't got any yet.

Once you're comfortable with the basic concept, you can start modifying the script and experimenting with different variations.<br> If you have any issues or need help, don't hesitate to contact me for assistance.<br>

# Architecture
* IShowShop is built using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* Model contains the necessary data and business logic needed for the shopping app, such as managing product information and processing transactions.
* View is responsible for displaying the data to the user, such as showing product lists and details.
* ViewModel handles user input or interactions, updates the Model, and updates the View as needed.
* The project includes a Firebase database for storing and retrieving data.

# Structure 
* "App": This is the root directory of the project. It contains the entry point of the application and any global configurations or settings.
* "Component": Contains reusable UI components that can be used throughout the application.
* "Core": This directory contains the main codebase of the application, including the implementation of the MVVM architecture. 
* "Extensions": Includes extension methods and utilities that add additional functionality to existing classes or simplify common tasks.
* "Models": Contains the data models used throughout the application.
* "Services": Includes services that handle business logic, communication with external APIs, or data processing tasks.
* "Utils": Contains utility classes and functions that provide common functionality used across the application.
* "Assets": Stores static files such as images, fonts, icons, and other resources needed by the application

# Dependencies
List of dependencies: 
* [Kingfisher](https://github.com/onevcat/Kingfisher) -> Kingfisher is used to download and display product images efficiently within the shopping app..
* [Firebase-iOS-SDK](https://github.com/firebase/firebase-ios-sdk) -> In this project, Firebase is used for backend services, including authentication, real-time database, cloud storage, and analytics. It helps in managing user data, synchronizing data in real-time, and providing secure authentication mechanisms.

# Screenshots

## User
<img width="250" alt="Home" src="https://github.com/abedsully/IShowShop/assets/113880556/3e9bd8f1-8de9-4012-91a1-f9a72489f0a0">
<img width="250" alt="Cart" src="https://github.com/abedsully/IShowShop/assets/113880556/0b6f54cd-46ee-4763-b36c-4c3c1cd71b1b">
<img width="250" alt="Notifications" src="https://github.com/abedsully/IShowShop/assets/113880556/3c6d8c21-e884-439a-ace6-cdfd0f151a95">
<img width="250" alt="Search" src="https://github.com/abedsully/IShowShop/assets/113880556/b69c4a74-1a4e-4ab8-a999-c27da70fec22">
<img width="250" alt="Search" src="https://github.com/abedsully/IShowShop/assets/113880556/4ea2d65e-0f00-4579-855e-7f6af5d84c36">
<img width="250" alt="Favorite" src="https://github.com/abedsully/IShowShop/assets/113880556/c3c1cec0-7a38-497d-8684-843442fd4563">

## Admin
<img width="250" alt="Home" src="https://github.com/abedsully/IShowShop/assets/113880556/c99fe60f-7022-4840-ae8c-4cff35a3ef10">
<img width="250" alt="Profile" src="https://github.com/abedsully/IShowShop/assets/113880556/bf10570e-0c60-4b27-b936-ae45a90cc1d2">
<img width="250" alt="Complete Order" src="https://github.com/thuanchung85/GoiAPI3/assets/113880556/7f600fec-8edc-478b-b944-90716b26bb49">


