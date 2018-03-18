# Patreon-iOS-SDK
[![iOS 8+](https://img.shields.io/badge/platform-iOS%209%2B-blue.svg)](https://img.shields.io/badge/platform-iOS%209%2B-blue.svg)
[![Swift 4](https://img.shields.io/badge/language-swift3-f48041.svg)](https://img.shields.io/badge/language-swift4-f48041.svg)
[![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://img.shields.io/badge/license-MIT-lightgrey.svg)


## Introduction
This an unofficial Patreon SDK for iOS. It not endorsed or affiliated with Patreon. Nevertheless I hope you will find it useful as there is no official SDK currently.

The project is written in Swift 4 and makes use of *Codable* for seamless JSON parsing. Minimum supported iOS is 8.0. The repo contains a *Patreon.xcodeproj* which produces the SDK in the form of a dynamic framework. There is also a sample app project to demontrate use of the SDK.

The SDK is light and self contained without requiring any external dependencies.

## Authentication
So far the SDK does not handle authentication. You are responsible of authenticating the user and obtaining the Access Token. There are 2 strategies for that:
* Use the **Creator's Access Token**. Make sure you don't bundle it with the app as this is a security risk. The best way it to use on-demand resources to download it after installing the app and then directly write it to the keychain. The SDK will automatically check in the keychain for the key named "AccessToken" before making each request and use it if it's there.
* Use OAuth2 authentication within the app. However this is not so straitforward as it requires a server component to complete the authentication process securely. For now this is not supported. You will have to figure it out on your own.

## API Resources
The SDK can access 3 different resources from the API
* User Profile
* Campaigns
* Pledges

## Example use
Compile the framework using *Patreon.xcodeproj*. Then drag it in your project and make sure you add it in "Embedded Binaries".

Import the Patreon module:

    import Patreon

Initialize a Patreon object:

    let patreon = Patreon()

Fetch the user's profile:

```
patreon.profile {
    (result) in
    switch result {
    case .success(let profile):
        //Hurray we got back the user's profile
    case .failure(let error):
        // Ooops something went wrong
    }
}
```

Fetch the user's campaigns:

```
patreon.campaigns {
    (result) in
    switch result {
    case .success(let campaigns):
        //Hurray we got back the campaigns
    case .failure(let error):
        // Ooops something went wrong
    }
}
```

Fetch the campaign's pledges:

```
patreon.pledges(campaignID: campaignID) {
    (result) in
    switch result {
    case .success(let pledges):
        //Hurray we got back the pledges
    case .failure(let error):
        // Ooops something went wrong
    }
}
```

Each method offers several overloads (e.g. allowing to provide an access token as an argument). For each of the API resources above there is a separate model struct which maps fields from the API one-on-one.


## Version History
- Version 0.1 (18/3/18)


The project is still in early stages and the API might change.
