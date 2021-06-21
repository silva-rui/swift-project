// swift-tools-version:5.3
import PackageDescription

let package = Package(
	name: "Game",
	products: [
		.executable(name: "Game", targets: ["Game"]),
	],
	dependencies: [.package(name: "InteractiveFictionFramework", url: "https://ds-git.fstc.uni.lu/Frameworks/interactive-fiction-framework.git", from: "0.0.2")],
	targets: [
		.target(name: "Game", dependencies: ["InteractiveFictionFramework"])
	]
)
