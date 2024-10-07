# Photo Stream for iOS
Technical test for IDnow

## Technical and architectural decisions

The Photo Stream app presents a gallery of photos taken by the user. The main interface displays a list of images, with detailed information shown upon selecting a photo. Additionally, users can capture new photos using the built-in camera feature.

- Folders
  - All view controller in /Views
  - All models in /Models
  - All the business logic in /Services
  - All views with advanced behavior in /Modules
  - All tests in /PhotoStreamTests
- Views
  - One view controller per feature: View, Details and Capture view controllers.
- Models
  - The app is using 1 model: Photo with an id, a date, an author name and an image.
- Services
  - The app is using 1 service: CollectionService which handles photo storage and API calls.
- Modules
  - The app is using 1 module: PhotoCollectionModule because an UICollectionView is a complex view that requires multiple classes to manage it efficiently
- External libs
  - alamofire through SPM to perform requests

## Backlog

### Project creation
The goal is to create a new and empty Xcode projet, create the first UIViewController, to setup a git repository, to setup iOS provisioning profiles.
Once done, you will be able to run the empty app on a simulator and an actual device.

### Main UI
The goal is to create the first view of the application.
It is composed of a title, an dismissable introduction text, a collection of image with default data and a button to start the capture view controller.
The collection service is not yet implemented, it will provide actual data later.

UI info
- Title : Welcome in Photo Stream !
- Introduction : We're thrilled to have you on board. Dive into your personal photo collection by scrolling through this screen, and unleash your creativity by capturing unique moments with our camera feature. Enjoy your experience!
  - Add a Dismiss button below the text
- CollectionView : use the remaining space to display the collection of photos

A Photo is composed of an id, a date, an author and a UIImage
Get pictures from internet to mock demo data.

### Details UI
When selecting a photo through the CollectionView, it should open a modal with an image, a title, the date and the author.
Export the current image through a button that open the native sharing UI. Add the entitlement to enable "Save to photos"

UI info :
- Display the image, then the title with the format "Photo \(photo.id)", the date with this format "Taken on 02/19/2024 at 10h30" and then the author
- A done button to the top right
- An export button next to the title

### Capture UI
Show the camera preview and a button to take a picture. Add the code to generate a UIImage.
The next task will connect this view controller to the collection service.

UI info :
- Full screen preview
- Transparent top bar
- Round button on the bottom to take the picture

### Collection Service
This service will handle the photo collection. It will load initial data, store it and call a backend to generate the author name.

API:
- generate collection : load initial data
- generate author : get a random author name from the dummyjson quotes api
- save photo : store a new Photo using a new UIImage and an author name

Update current code:
- Connect the photo collection view model and use data from generate collection method
- Generate an anthor name and save picture taken in capture ui (also handle Simulator with an image from assets)
- Add a progress dialog when requesting the dummy api

Add tests to test all APIs.

## Next Steps
- Enhance the UI.
- Use storage to persist some application behaviors (such as dismissing the intro) and to locally cache the photo collection.
- More background processing tasks to enhance UX.
- Setup CI/CD tasks.

## Time spent
- About 6h on the application development.
- About 1h on the README.md
