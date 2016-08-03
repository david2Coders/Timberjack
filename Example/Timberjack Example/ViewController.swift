import UIKit
import Timberjack

class ViewController: UIViewController {
    
    @IBAction func requestPressed(sender : AnyObject) {
        requestURL2()
    }
    
    func requestURL() {
        let url = NSURL(string: "http://httpbin.org/get")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url)
        
        task.resume()
    }
    
    func requestURL2() {
        let session = NSURLSession.sharedSession()
        
        guard let URL = NSURL(string: "http://httpbin.org/get") else {return}
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // JSON Body
        
        let bodyObject = [
            "name": "名称",
            "avatar": "aaaaaa"
        ]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(bodyObject, options: [])

        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
//        session.fisnishTaskAndInvalidate()
    }
}

