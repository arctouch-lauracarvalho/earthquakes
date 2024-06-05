# Earthquakes App

This Earthquake App provides a list of Earthquakes. 
Each Earthquake shows where it happenend, the date it happen, how depth it was and its magnitude.
If you tap the Earthquake row it will display its locations on a map.
The app is built using SwiftUI, MapKit and follows the MVVM architecture.

## Requirements
- Xcode 15.4 or later
- iOS 16.0 or later

## Features

- Portrain only
- Fetches and displays a list of Earthquakes
- Earthquakes with a magnitude of 7.5 or higher have that value highlighted in red
- Tapping on an Earthquake row shows its location on a map.
- If any error occur an alert is displayed

## Technologies Used

- Swift
- SwiftUI
- Combine
- MapKit
- MVVM Architecture

## Installation

To run the project, you need to have Xcode installed on your Mac.
Follow these steps:

1. Clone the repository, using SSH:
    ```sh
    git clone git@github.com:yourusername/earthquakes.git
    ```

2. Open the project using Xcode:
    2.1 Open the terminal and go the the folder where you cloned the repo
    ```sh
    cd Earthquakes
    open Earthquakes.xcodeproj
    ```

3. Build and run the project in the simulator.

## Usage

With the app running, it will automatically fetch and display a list of Earthquakes.
You can scroll through the list to see each Earthquake.
Tapping on an Earthquake row will show a new screen with its location on a map.

## Acknowledgements

- The Earthquake data is provided by the [USGS Earthquake API](https://earthquake.usgs.gov/fdsnws/event/1/).
