# Readdle-2020-Internship
Test task for the iOS Internship at Readdle 2020

## Task description
Create a "Contacts" app for both iPhone and iPad.

![People List](https://github.com/un0dvendig/Readdle-2020-Internship/blob/assets/PeopleList.png?raw=true) ![People Grid](https://github.com/un0dvendig/Readdle-2020-Internship/blob/assets/PeopleGrid.png?raw=true) ![Person](https://github.com/un0dvendig/Readdle-2020-Internship/blob/assets/Person.png?raw=true)

App has "People" and "Detailed Info" screens.
Screen "People" should contain:
 * Switcher of the view: list/grid 
 * The list cell has a height 50pt. It contains avatar, status, name
 * A grid cell is 50x50pt. It contains avatar, status
 * Button "Simulate Changes" that significantly and randomly change the application model (change account statuses, names, remove users, and add users).
 * After tapping on a cell, the app shows detailed info for the selected user.

Screen "Detailed Info" should contain:
 * Big avatar
 * Account status
 * Name
 * Email

### Requirements:
 * Application Model should live in a separate background thread.
 * Use Gravatar for avatars.

### Will be a plus:
 * The animated transition between list/grid view - avatars should move to a new place.
 * The animated transition between "People" and "Detailed Info" - the selected avatar should move to a new place.

### Will be a huge plus:
 * Implement UI fully in code.
 * Write tests.


## Run manual

 1. Clone or download this repo.
 2. Run `pod install` from the project folder.
 3. Open `Readdle 2020.xcworkspace` and run the project on selected device or simulator.
 
 ## TODO
 
 - [ ] Add transition animation
 - [ ] Add collection view layout animation change
