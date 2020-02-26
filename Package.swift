// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

#if os(Linux)
let targets: [Target] = [
	.systemLibrary(
			name: "libxmlKanna",
			path: "Modules",
			pkgConfig: "libxml-2.0",
			providers: [
				.brew(["libxml2"]),
				.apt(["libxml2-dev"])
			]),
	.target(name: "Kanna",
			dependencies: ["libxmlKanna"],
			path: "Sources",
			exclude: [
				"Sources/Info.plist",
				"Sources/Kanna.h",
				"Tests/KannaTests/Data"
			]),
	.testTarget(name: "KannaTests",
				dependencies: ["Kanna"]
			)
]
#else
let targets: [Target] = [
	.target(name: "Kanna",
			dependencies: [],
			path: "Sources",
			exclude: [
				"Sources/Info.plist",
				"Sources/Kanna.h",
				"Tests/KannaTests/Data"
			],
            linkerSettings: [.linkedLibrary("xml2")]
	),
	.testTarget(name: "KannaTests",
				dependencies: ["Kanna"]
			)
]
#endif

let package = Package(
    name: "Kanna",
    products: [
      .library(name: "Kanna", targets: ["Kanna"]),
    ],
    targets: targets
)
