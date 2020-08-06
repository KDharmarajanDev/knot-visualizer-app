# knot-visualizer-app

knot-visualizer-app is an iOS application fueled by ARKit that displays the progression of knot tying in one's environment with the goal of educating the end user.

<div align="center">
  <img src="https://user-images.githubusercontent.com/52500655/89469849-3290b300-d72f-11ea-9ee7-23a3d1f0c4f3.gif" alt="Inserting Two Half-Hitches">
</div>

## Installation

1. Clone the repository with the following command: `$ git clone https://github.com/KDharmarajanDev/knot-visualizer-app`

2. Open `Knot Visualizer.xcodeproj` in XCode.

3. Connect the desired device of choice and select that device in XCode.

4. Hit the play button to download it to the device.

5. If the app isn't opening due to permissions, go to `General > Device Management` and verify this app.

## Usage

### Learning a Knot

1. Tap the `Knots` button on the top left or swipe to the right to open the sidebar with possible Knots.

2. Click on the desired knot to see.

3. Tap on the screen to place the knot at the location tapped.

4. Use the slider, backwards, and forwards arrows to progress through the different states of the knot.

### Adding Custom Knots

1. Open `Knot Visualizer/Resources/Knots.xml` in XCode

2. Under the latest `</Knot>` add `<Knot> </Knot>`.

3. Each `Knot` requires a name, `Thumbnail`, and at least one `KnotState`.

4. Give the knot a name by placing text after the `<Knot>` tag.

5. Insert `<Thumbnail> </Thumbnail>` with the name of the image file of the thumbnail in between the tags. The thumbnail image file only needs to be within the general directory of the Knot Visualizer project. For best practices, it is recommended that the file goes in the `Knot Visualizer/Resources/Thumbnails` directory.

6. Add at least one `<KnotState></KnotState>`. Inside, place the name of the file of the 3d model that represents that knot state __without the extension__. Only `.dae` files are supported in this app. `KnotStates` are sequential, meaning that they will be displayed in the order specified in the XML file from top to bottom. Example: for file TwoHalfHitchState1.dae, the XML value is `        <KnotState>TwoHalfHitchState1</KnotState>`. For best practices, ensure all `KnotStates` have the same origin, or do not move too far from the previous state.

## Contributing

When contributing, please follow the above guidelines for adding more knots. Contributions on the UI design are also welcome.

## License
This application uses the MIT License, and is unpublished on the App Store.
