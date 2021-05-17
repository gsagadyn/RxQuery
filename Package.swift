// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxQuery",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "RxQuery", targets: ["RxQuery"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMinor(from: "5.4.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.2.0")),
    ],
    targets: [
        .target(name: "RxQuery", dependencies: ["Alamofire", "RxSwift", "RxCocoa"], path: "RxQuery")
    ]
)
