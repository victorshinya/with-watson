[![](https://img.shields.io/badge/IBM%20Cloud-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-swift-lightgrey.svg?style=flat)](https://developer.ibm.com/swift/)

# Use the cognitive capabilities of your iOS App with Core ML and Watson | With Watson

This iOS application uses the Watson Visual Recognition service to analyze images taken on iPhone or album photos using a user-trained model on the Watson Studio platform (also known as the *Data Platform*). In this way, you can understand how to integrate a [Watson API](https://cloud.ibm.com/catalog?category=ai) into a Swift project with the use of the [Swift SDK](https://github.com/watson-developer-cloud/swift-sdk).

Access [Dropbox](https://ibm.biz/dataset) to download the available Datasets, or create your own set of images.

If you want to read this content in *Brazilian Portuguese*, [click here](https://github.com/victorshinya/with-watson/blob/master/README-pt.md).

![](https://github.com/victorshinya/with-watson/blob/master/doc/source/images/architecture.jpg)

## Componentes e tecnologias usadas

* [Watson Visual Recognition](https://cloud.ibm.com/catalog/services/visual-recognition): Analyze images for scenes, objects, faces and other content.
* [Watson Studio](https://cloud.ibm.com/catalog/services/watson-studio): Data platform with collaborative environment and toolkit for Data Scientist, Developers and SMEs.
* [Cloud Object Storage](https://cloud.ibm.com/catalog/services/cloud-object-storage):  Object storage service in the cloud.
* [Swift](https://developer.apple.com/swift/): Open-source programming language for Apple devices.

## How to install and configure locally

To install the application it is necessary that you have installed the latest version of [Xcode](https://developer.apple.com/xcode/) and [Cocoapods](https://cocoapods.org) (dependency manager for Swift and Objective-C projects).

### 1. Get the app

```sh
git clone https://github.com/victorshinya/with-watson.git
cd with-watson/
```

### 2. Download all app dependencies

```sh
pod install
```

### 3. Open the "With Watson.xcworkspace" file

```sh
open With\ Watson.xcworkspace
```

### 4. Open the Constants.swift file

Open the file and fill it in with the Watson Visual Recognition credential and the trained Visual Recognition template - done within Watson Studio.

### 5. Execute with the CMD + R command (or press the play button)

Now run the project on the Xcode simulator or on your own iPhone / iPod / iPad. Remember that it is not possible to open the camera inside the simulator.

## License

MIT License

Copyright (c) 2018 Victor Kazuyuki Shinya
