# SKImageCache

![Travis Status](https://travis-ci.org/skladek/SKImageCache.svg?branch=master)
![Codecov Status](https://img.shields.io/codecov/c/github/skladek/SKImageCache.svg)
![Pod Version](https://img.shields.io/cocoapods/v/SKImageCache.svg)
![Platform Status](https://img.shields.io/cocoapods/p/SKImageCache.svg)
![License Status](https://img.shields.io/github/license/skladek/SKImageCache.svg)

SKImageCache provides an object to handle image loading and caching. Check out the SampleProject in the workspace to see some usage examples.

- [Installation](#installation)
- [Initialization](#initialization)
- [Implementation](#implementation)
- [ImageCacheDelegate](#imagecachedelegate)
- [UIImageView Extension](#uiimageview-extension)

---

## Installation

### Cocoapods

Instalation is supported through Cocoapods. Add the following to your pod file for the target where you would like to use SKImageCache:

```
pod 'SKImageCache'
```

---

## Initialization

There are no publically exposed initializers. It is expected that all interactions with the cache are handled through the shared instance:

```
ImageCache.shared
```

---

## Implementation

### Adding an image to the cache

The `cacheImage(_:forURL:)` method is used to add an image to the cache. The image's remote URL is required and is used as the key to access the image from the cache.

### Emptying the cache

The entire cache can be emptied by calling the `emptyCache()` method.

### Retrieving an image from the cache

Use the `getImage(url:skipCache:completion:) -> URLSessionDataTask?` method to retrieve an image from the cache. The URL is the remote URL of the image. The skipCache parameter can be used if you would like to force the request to access the remote source for the URL. The completion closure will contain the image, a boolean indicating if the image was returned from the cache, and any error encountered while retrieving the image. The method itself returns an optional URLSessionDataTask. If a remote request has to be made to retrieve the image, this data task should be the remote task. This allows image requests to be cancelled if necessary, for instance, if the view requesting the image is no longer visible.

### Removing a single object

A single object can be removed from the cache using the `removeObjectAtURL(_:)` method.

## ImageCacheDelegate

Images that are not found in the cache will request an image from the delegate object. This allows the image cache to be connected to your existing networking layer. The `loadImageAtURL(_:completion:) -> URLSessionDataTask?` method will be called on the delegate when the image was not found in the cache and should be loaded from an external source.

## LocalImageController

A LocalImageController class is provided to allow managing saving, retrieving, and deleting images from disk. This can be used independently of the ImageCache.

### Save an image

To save an image, use the `saveJPEG(_:compression:fileName:directory:)` or `savePNG(_:fileName:directory:)` method. The image will be converted to data and saved to disk in the format corresponding to the method. The file name is what the image will be named on disk. The directory is an optional parameter. Pass a path in here to specify folders deeper than the documents directory. If the folder does not exist, it will be created.

### Retrieve an image

Images can be retrieved with the `getImage(imageName:directory:)` method. Pass in the name of the file and the path from the documents directory. If no path parameter is passed in, the documents directory will be searched.

### Delete a directory

Deletes the specified folder and all of its contents.

## UIImageView Extension

SKImageCache provides an extension to UIImageView. This allows an image to be set on the image view using the image's URL. Use the `setImageFromURL(_:placeholderImageName:) -> URLSessionDataTask?` method. The URL is the remote URL of the image to fetch. The placeholderImageName is the name of the image in the bundle to be displayed until the remote or cached image is returned. If the image is returned from the cache, the image will immediately be swapped. If the image is returned from a remote source, the images will be crossfaded.