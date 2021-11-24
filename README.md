# Shortcut-code-challenge UIKit Version

## Some notes before reviewing code and commits.

### You may see some commits were failed because of following reasons:

- Failure reason for the second commit until the 14th: It was because of the iOS deployment version that is not compatible with Github CI ( you can check and see the Bitrise tests were succeeded).

- The commit `4aa2ec5bba9ebc800a48f9feb82a89b200487e79` - `add backgroundFetch and Notification` failed because of something on Bitrise ( It has been succeeded on GitHub CI), and it could pass all tests when I merged the branch to master.

- From commit (add detailVC) until the next four commits failed because of the `testDetailViewLoadImageAndFullScreen()` UITest, it is a test that depends on external data( from server), even though I know this test is a wrong test and I must not write tests which depend on external things, I have written it to show I am able to write UITests for child pages. ( I disabled this test from four commit after `7848fc3f6847c5ff31082ff0780fab64be1b497f`) 


### Why I chose DispatchQueue as  threading way:

I wanted to use `async await` instead of dispatch queues and closures ( because it’s the new brand technology for swift multithreading), but I could not use it because the minimum deployment target for using `async await` is iOS 15 and the maximum deployment target for Github CI is iOS 14. so I enforced to use dispatch queue.

### Why I wrote a few UITests:
Because approximately all parts of the project depend on external data ( if you want to create a test for share button or favorite button on detail, the API on the first page must be loaded, and also the image on the detail page must be loaded and they cause to fail the test.( for the favorite button I enforced to download image before because user be able to use the app offline))


### Why the Git has just one permanent branch:
Because it is a small project and development branch is not necessary for this project, development branch uses when we want to gather several features and submit a version to the AppStore. ( we can add it when it will be necessary).
 
——————
## Notes for CI:
You can find 3 kinds of CI configuration on the project (‘.github/workflows/CI.yml` for Github CI, `bitrise.yml` for bitrise.io CI, and ci.sh for Jenkins - as you know Jenkins is an internal CI, but I used it because I speculated may you use Jenkins and show I am familiar with it )





### Services and network portion

#### Services
This class is responsible for generating URL and also loading an image from a remote server

Relative tests for this class are:

```swift
ServicesTest.testgenerateCurrentUrl()
ServicesTest.testGenerateSpecificComicUrl()
```




##### Network
This class is responsible for connecting to the remote server and handling the success state or failure with appropriate escaping functions.


The following func responsible for getting data from a remote server (API) and calling appropriate closure (success or failure)


```swift
func getData<T: Codable>(url: URL?, success _success: @escaping(T) -> Void,
                             failure _failure: @escaping(NetworkErrors) -> Void) 
```


##### NetworkErrors

This class consist of network error types and it consists of two parts networkError titles and error descriptions (string)


##### ServerEnvironments

This Plist file has two string parameters that are used for creating URL


##### Chain network
This group is responsible for throwing objects model or choosing appropriate action if the server's response status code is not succeeded 

Relative tests for this group are: 

```swift
ServicesTest.testResponse200()
ServicesTest.testChainNotResponse404()
ServicesTest.testServerError500()
ServicesTest.testEndOfChainWithUndefindedStatusCode()
```

#### DataStorage

this class is responsible to save and retrieve data from CoreData

Relative test for this class is:

```swift
ServicesTest.testSaveComicOnCoreData()
```


### Extensions

#### Int:
 I just added a variable to make it convenient to check the success HTTP code.

#### Collection:
It uses to prevent `Index out of range` error for an array.


Relative test to it is:

```swift
ExtensionTest.testIsNilArray()
```

#### Date:
I have added two functions for converting String to date and convert date to a long format string.

Relative tests for this file are:

```swift
ExtensionTest.testCheckEqualDate()
ExtensionTest.testCheckDateWithOnlyYear()
ExtensionTest.testConvertToLongDate()
```




### Model

The model portion has 3 classes that one of them related to remote API (ComicModel) and two others use for CoreData.



### Viewcontroller

View controller has 3 parts that will be explained:

#### Browse controller

This part includes browsing and searching comics

Relative UItest for this group is :

```swift
// It may be failed because it depends on external data, but I just wrote to show I can write UItests as well.
shortcut_code_challenge_UIKitUITests.testCheckIsARowLoaded()
```

##### BrowseVC.swift

It is the main class for browse controller 

* Comics are getting one by one from current to 1 and they receive every 20 `comicBunchCount:Int` and even you scroll to the bottom of table view 20 others will be loaded 

##### BrowseTVC.swift

This class uses to show comic cells


##### BrowseTVHandler.swift
 An extension of BrowseVC for handling tableView
 
 The following func uses to load a bunch of comics
 
 ```swift
 func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
 ```
 
 ##### WaitingTVC.swift
 This class uses for waiting for indicator cell
 
 ##### SearchSRUHandler.swift
 This extension handles search activity
 
 ##### SearchSBHandler.swift
 This is an extension of browseVC to get searchbar delegation funcs.
 
 ##### NotificationPermission.swift
 
 This extension uses to get push notification permission from users. it is called on `BrowseVC->viewDidLoad()`
 
 
 ----
 
 
 #### DetailVC
 
 This class is the only class for detail view, 
 
 * Comic can save to favorite after loading image. `bookMarkButtonPress(_:)`
 * Comic photo be able to share after the image is loaded completely. `shareButtonPress(_:)`


----


#### Favorite Controller

##### FavoriteVC.swift
This is the main class of Favorite view, this part loads only data saved on coreData.

##### FavoriteTVHandler.swift

The is an extension of favoriteVC for handling its tableview.

* You can remove a favorite object with swap it:

```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let itemId = data[indexPath.row].num
            DataStorage().removeComic(for: itemId)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
```


### IBDesignable

There is just a class to create a custom rounded button for using as share button `Custom Button.swift`


### Enums

#### publicNamesEnum.swift
This enum file uses for saving public keys for communicating to userDefaults to save and fetch simple objects.


### notify new comics
It is handled by `BGTaskScheduler` that is defined on appDelegate.



### More Informations about the project
- There are two options for saving favorite data on the device, first is using userDefault for saving the model and saving images on the project's document folder. the next one is using core data to save them. I used the second one because it seems more complex and you may judge me better.

