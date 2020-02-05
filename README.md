# ReadTime plugin for Publish

A [Publish](https://github.com/johnsundell/publish) plugin that makes it easy to get a read time for your articles.

[![Build Status](https://app.bitrise.io/app/bc6358842e4236d8/status.svg?token=k1-KrBo3XG1DDKqr96EBlw&branch=master)](https://app.bitrise.io/app/bc6358842e4236d8)

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/artrmz/ReadTimePublishPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "ReadTimePublishPlugin"
            ]
        )
    ]
    ...
)
```

For more information on how to use the Swift Package Manager, check [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

```swift
import ReadTimePublishPlugin
...
.unwrap(item.readTime().time, { .span("\($0) min") })
...
```
