#Timberjack

Automatic Swift network activity logger for iOS or OSX.

![Cocoapods](https://img.shields.io/cocoapods/v/Timberjack.svg?style=plain) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![MIT](https://img.shields.io/cocoapods/l/Timberjack.svg?style=flat) ![iOS](https://img.shields.io/cocoapods/p/Timberjack.svg?style=flat)

Timberjack is a simple, unintrusive network activity logger. Log every request your app makes, or limit to only those using a certain `NSURLSession` if you'd prefer. It also works with [Alamofire](https://github.com/Alamofire/Alamofire), if that's your thing.

*Note, Timberjack is written in Swift 2.0, so you'll need Xcode7 to build. If you're using Swift 1.2, there's a compatible version on the swift-1.2 branch*

- Enable logging across your app with just 1 line of code
- Verbose and Light debugging modes
- Works with `NSURLSession`, `NSURLConnection`, `Alamofire` and pretty much any networking framework
- Pretty printed `JSON` responses
- Useful for debugging and development, but probably best not to ship your app with verbose logging.

```bash
Request: POST http://localhost/auth/clientAuth
Headers: [
  Content-Length : 50
  Content-Type : application/json
]
JSON: {
  "identifier" : "13800000000",
  "password" : "12345678"
}
---------------------
Response: http://localhost/auth/clientAuth
Status: 200 - No Error
Headers: [
  Vary : X-HTTP-Method-Override
  X-Powered-By : Sails <sailsjs.org>
  Content-Length : 726
  Content-Type : application/json; charset=utf-8
  Date : Wed, 03 Aug 2016 06:15:57 GMT
  Etag : W/"2d6-Bf3fbK1NkF1VTo0N/15fDQ"
  Connection : keep-alive
]
Duration: 0.167722046375275s
JSON: {
  "headImg" : "qwerqqewqerqe",
  "updatedAt" : "2016-08-03T06:07:04.183Z",
  "id" : "57997ab8b6df75af41de02d8",
  "sex" : "female",
  "mobile" : "15189345238",
  "owner" : "57997ab8b6df75af41de02d5",
  "birthDay" : "2016-08-03T00:00:00.000Z",
  "birthday" : "1970-01-01",
  "createdBy" : "57997ab8b6df75af41de02d5",
  "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzaWQiOiI1Nzk5N2FiOGI2ZGY3NWFmNDFkZTAyZDUiLCJpYXQiOjE0NzAyMDQ5NTd9.dVP-h9WqXxsx1NpJLdZX5izZWCeyk4GFL6foB4d92hs",
  "friends" : [
    "5798d337b4e857d320412a61"
  ],
  "createdAt" : "2016-07-28T03:23:36.671Z",
  "name" : "名称"
}
```

##Installation

Timberjack is installed as an embedded framework, and such requires at least iOS8. If you require iOS7 compatibility, simply drag the `Timberjack.swift` file into your own project.

###Cocoapods

Add the following to your Podfile

````ruby
platform :ios, '8.0'
use_frameworks!

pod 'Timberjack', :git => 'git@github.com:senpng/Timberjack.git'

````

Then install with `pod install`

###Carthage

Add the following to your Cartfile

````ruby
github "senpng/Timberjack" >= 0.0.1
````

##Usage

Nice and easy, just register when your app loads, and Timberjack will monitor and log any requests you make via `NSURLSession` or `NSURLConnection`.

````swift
import UIKit
import Timberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Timberjack.register() //Register Timberjack to log all requests

        return true
    }
}
````

###Using with Alamofire

Due to the way Alamofire uses NSURLSession, you'll need to do a little more than the standard installation to monitor all requests. The simplest way to do this is to create a subclass of `Manager` to handle your requests, then just use this in place of `Alamofire.request()`.

````swift
import Alamofire
import Timberjack

class HTTPManager: Alamofire.Manager {
    static let sharedManager: HTTPManager = {
        let configuration = Timberjack.defaultSessionConfiguration()
        let manager = HTTPManager(configuration: configuration)
        return manager
    }()
}
````

###Configuration

Timberjack has two modes: Verbose and Light. The default style is `Verbose`. To change this, just set it appropriately.

````swift
Timberjack.logStyle = .Verbose //Either .Verbose, or .Light
````

##License

MIT, see LICENSE for details.

##Bugs or Issues

Open an issue here, or ping me a message on Twitter. Even better, fork this repo and open a pull-request!

*Unfortunately, due to a limitation in `NSURLProtocol`, Timberjack is unable to log the HTTP body of a request, see [This radar](http://openradar.appspot.com/15993891) for more details*

##Credits

Built by [@andyjsmart](https://twitter.com/andyjsmart)
