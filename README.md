# Photo Stream for iOS
Technical test for IDnow

## Technical and architectural decisions 

## Backlog

### Project creation
The goal is to create a new and empty Xcode projet, create the first UIViewController, to setup a git repository, to setup iOS provisioning profiles.
Once done, you will be able to run the empty app on a simulator and an actual device.

### Main UI
The goal is to create the first view of the application.
It is composed of a title, an dismissable introduction text, a collection of image with default data and a button to start the capture view controller.

UI info
- Title : Welcome in Photo Stream !
- Introduction : We're thrilled to have you on board. Dive into your personal photo collection by scrolling through this screen, and unleash your creativity by capturing unique moments with our camera feature. Enjoy your experience!
  - Add a Dismiss button below the text
- CollectionView : use the remaining space to display the collection of photos

A photo is composed of an id, a date, an author and a UIImage
Get pictures from internet to mock demo data.

### Details UI
When selecting a photo through the CollectionView, it should open a modal with an image, a title, the date and the author.

UI info :
- Display the image, then the title with the format "Photo \(photo.id)", the date with this format "Taken on 02/19/2024 at 10h30" and then the author
- A done button to the top right

### Capture UI

### Collection Service

### Enhance behavior

## Next Steps
- Enhance the UI.
- Use storage to persist some application behaviors (such as dismissing the intro) and to locally cache the photo collection.
- More background processing tasks to enhance UX.
- Setup CI/CD tasks.

## Time spent
- About 6h on the application development.
