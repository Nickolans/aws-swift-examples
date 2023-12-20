// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aws-swift",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(
            url: "https://github.com/awslabs/aws-sdk-swift",
            from: "0.17.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "aws-swift",
            dependencies: [
                .product(name: "AWSS3", package: "aws-sdk-swift"),
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),
                .product(name: "AWSIAM", package: "aws-sdk-swift"),
                .product(name: "AWSKinesis", package: "aws-sdk-swift"),
                .product(name: "AWSKinesisAnalytics", package: "aws-sdk-swift"),
                .product(name: "AWSLambda", package: "aws-sdk-swift"),
                .product(name: "AWSNeptune", package: "aws-sdk-swift"),
                .product(name: "AWSSNS", package: "aws-sdk-swift"),
                .product(name: "AWSSNS", package: "aws-sdk-swift"),
                .product(name: "AWSSQS", package: "aws-sdk-swift"),
                .product(name: "AWSSageMaker", package: "aws-sdk-swift")
            ],
            path: "Sources"),
    ]
    
)
