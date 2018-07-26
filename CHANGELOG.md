# Change Log
All notable changes to this project will be documented in this file.

#### 2.x Releases
- `2.2.0` Releases - [2.2.0](#220)
- `2.1.0` Releases - [2.1.0](#210)
- `2.0.0` Releases - [2.0.0](#200)

#### 1.x Releases
- `1.3.0` Releases - [1.3.0](#130)
- `1.2.0` Releases - [1.2.0](#120)
- `1.1.0` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101)

## [2.2.0](https://github.com/skladek/SKImageCache/releases/tag/2.2.0)

#### Added
- The ability to define a global default image directory to save images to.

## [2.1.0](https://github.com/skladek/SKImageCache/releases/tag/2.1.0)

#### Added
- Images can be saved to a path including their url path. This is useful for situations where a server returns images with the same name but a different path. For instance, take following URLs:
```
    http://example.com/folder1/image.jpg
    http://example.com/folder2/image.jpg
```
- The first URL will be saved locally at `Documents/folder1/image.jpg` the second will be saved locally at `Documents/folder2/image.jpg`. The key for each will be `folder1/image.jpg` and `folder2/image.jpg` respectively. This allows images with the same lastPathComponent to be used in the same cache.

## [2.0.0](https://github.com/skladek/SKImageCache/releases/tag/2.0.0)

#### Added
- Swift 4 support.

## [1.3.0](https://github.com/skladek/SKImageCache/releases/tag/1.3.0)

#### Added
- A LocalImageController to handle saving, retrieving, and deleting images from disk.

## [1.2.0](https://github.com/skladek/SKImageCache/releases/tag/1.2.0)

#### Added
- An optional completion closure on the UIImageView extension to allow errors to be reported to the caller.

## [1.1.0](https://github.com/skladek/SKImageCache/releases/tag/1.1.0)

#### Added
- An option to allow saving files to disk in addition to the cache.
- An option to delete local file directories from the image cache.

## [1.0.1](https://github.com/skladek/SKImageCache/releases/tag/1.0.1)

#### Added
- README navigation
- Changelog

#### Removed
- Header copyrights which were preventing Cocoadocs from processing the tests.

#### Updated
- SKTableViewDataSource to 1.0.1
- SKWebServiceController to 0.0.6

## [1.0.0](https://github.com/skladek/SKImageCache/releases/tag/1.0.0)

#### Added
- Initial release.
