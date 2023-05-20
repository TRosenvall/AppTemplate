# App Template

This template has been built to utilize a dual approach to app development and has been designed to be easily extensibly.
Included in this template are services for persistence, json coding, encryption, networking, data expiration and analytics 
as well as frontend modules for launching the app, a home screen and settings menu, and an activity indicator.

## Backend

The first peice is the backend which uses services as the main components. A service is anything which the user won't be
interacting with directly. (I.E. Networking, encryption, analytics, etc.) These services can be used by any object conforming
to the `ServicesRequiring` protocol which will give access to the `getService()` function. In order to add additional services,
start by adding the service name to the `UtilityType.Services` enum found [here](./AppTemplate/Shared/AppTemplateName.swift).
Then build the project and let the errors tell you what's missing. The errors thrown have been designed to guide you through
the creation of additional services. Create the new files and objects as needed. Note that each service needs a unique `loadPriority`
identifier. These determine the load order of the services starting with the smaller `loadPriority`s first. The first two services 
to be loaded are the `Encryption` and `Analytics`services and they must be loaded in that order. 

TODO: - Add a script to add additional services.

## Frontend

The second peice is the frontend which uses modules as the main components. A module is anything which the user will be interacting
with directly. The modules follow the VIPER architecture. In order to facilitate faster loading times of potentially larger modules,
each module tracks additional modules to which can be routed from the current module. Those extra modules are built and stored in an
`onDeck` array. In order to add additional modules, start by adding the module name to the `UtilityType.Modules` enum found 
[here](./AppTemplate/Shared/AppTemplateName.swift). Then build the project and let the errors tell you what's missing. The errors 
thrown have been designed to guide you through the creation of additional modules. Create the new files and objects as needed.

TODO: - Add a script to add additional services.

## Data Storage

Both the backend and frontend peices may need to persist data. Any data which needs to be persisted should be added to the respective
`<Service>Variables` or `<Module>Variables` enum. These enums have been built in order to provide additional information on how each
piece of data should be handled. Each service and module also holds an `EntityController` which handles the storage of data on that
utility's entity. Since both services and modules use `Entity`s and `EntityController`s, source files for these objects can be found
in the shared folder.

#TODO THOUGHTS

/// enum displayType {
///     // Default, this value won't be displayed in the settings menu.
///     case none
///
///     // This case will appear but won't be able interactable to the user.
///     case display (section: String = "", priority: Int = 0)
///
///     // This case will not display any data to the user, but when tapped will clear the current menu option and
///     // display the page of the cell's title.
///     case newPage (section: String = "", priority: Int = 0)
///
///     // This case will route out of the app to the user's native browser and display the url of the given variable.
///     case nativeBrowser (section: String = "", priority: Int = 0)
///
///     // This case will route into a webview within the app and display the url of the given variable.
///     case webView (section: String = "", priority: Int = 0)
///
///     // This case will route to a new view controller
///     case route (section: String = "", priority: Int = 0)
///
///     // This case will display a cell for a boolean value. The cell will contain a switch to reverse the current
///     // value
///     case boolean (section: String = "", priority: Int = 0)
///
///     // This case will display an integer value. The cell will contain a two buttons to raise or lower the value.
///     case int (section: String = "", priority: Int = 0, minValue: Int, maxValue: Int)
///
///     // This case will display an float value. The cell will contain a slider to raise or lower the value. If tapped,
///     // the slider will enlarge and center on the screen while dimming the background in order to give more fine
///     // control on the value.
///     case bool (section: String = "", priority: Int = 0, minValue: Float, maxValue: Float)
///
///     // This case will display a string value as a textField. The cell will contain a text field. If tapped, the
///     // textField will focus on the screen, enlarging and centering while the background is dimmed.
///     case textField (section: String = "", priority: Int = 0, placeholder: String = "<placeholder>")
///
///     // This case will display a string value as a textView. The cell will lengthen to contain the whole textView.
///     // If tapped, the textView will focus on the screen, enlarging and centering while the background is dimmed.
///     case textView (section: String = "", priority: Int = 0, placeholder: String = "<placeholder>"
/// 
/// Within the `SettingsDataSource` a section object can be built containing the needed values.

