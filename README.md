###Facebook Explorer
----
In order to compile the project open **FBxplr.xcworkspace**

### Dependencies
Dependencies are managed using  [**CocoaPods**](http://www.cocoapods.org).  

Run  <code>pod install</code> from bash to update dependencies.




All these libraries are essential for advanced iOS development

* [**MBProgressHUD**](http://www.bukovinski.com/) An iOS activity indicator view.<br>
<code>pod 'MBProgressHUD', '~> 0.5'</code>

* [**DCIntrospect**](https://github.com/domesticcatsoftware/DCIntrospect) is small set of tools for iOS that aid in debugging user interfaces built with UIKit. It's especially useful for UI layouts that are dynamically created or can change during runtime, or for tuning performance by finding non-opaque views or views that are re-drawing unnecessarily. It's designed for use in the iPhone simulator, but can also be used on a device. <br> 
<code>pod 'DCIntrospect', '~> 0.0.2'</code>

* [**InAppSettingsKit**](https://github.com/futuretap/InAppSettingsKit) is an open source solution to to easily add in-app settings to your iPhone apps.<br>
<code>pod 'InAppSettingsKit', '~> 1.0'</code>
 
* [**ISO8601DateFormatter**](https://bitbucket.org/boredzo/iso-8601-parser-unparser/) is a standard Date formatter  <br>
 <code>pod 'ISO8601DateFormatter', '~> 0.6'</code>
 
* [**AFNetworking**](https://github.com/futuretap/InAppSettingsKit) A delightful iOS and OS X networking framework. <br>
<code> pod"AFNetworking", "~> 2.0"</code>  

* [**Reachability**](https://github.com/tonymillion/Reachability) ARC and GCD Compatible Reachability Class for iOS and OS X. Drop in replacement for Apple Reachability.<br>
<code>pod 'Reachability', '~> 3.1.0'</code> 

* [**Facebook-iOS-SDK**](https://developers.facebook.com/docs/ios/) The iOS SDK provides Facebook Platform support for iOS apps.<br>
<code>pod 'Facebook-iOS-SDK', '~> 3.11.0'</code>

* [**TPKeyboardAvoiding**](https://github.com/michaeltyson/TPKeyboardAvoiding) A drop-in universal solution for moving text fields out of the way of the keyboard in iOS.<br>
<code>pod 'TPKeyboardAvoiding', '~> 1.2.1'</code>

* [**FlatUIKit**](https://github.com/Grouper/FlatUIKit) A collection of awesome flat UI components for iOS.<br>
<code>pod 'FlatUIKit', '~> 1.2'</code>

 
----
### Features
* Universal App (iPhone/iPad) (TODO)
* Facebook Login Auth
* CoreData Integration (Easy Implementation)
* FB Pop Animation Framework Integration (TODO) 
* Works automagically on ARC and non-ARC enviroment - more info [Utils/DevDefines.h](https://github.com/RIAlizer/FBxplr/blob/master/FBxplr/FBxplr/Utils/DevDefines.h) (useful for backward compatibility) 
	* Target FBxplr for non-ARC
	* Target FBxplrARC is ARC enable (TODO)