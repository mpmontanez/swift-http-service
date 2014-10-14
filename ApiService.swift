//
//  Api/Http Service
//

import Foundation

struct ApiService
{
    // Executes an HTTP GET request.
    static func get(path: String, completionHandler: ((NSDictionary) -> Void)!)
    {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                // If there is an error in the web request, print it to the console.
                println("Api Call Error: \(error!.localizedDescription)")
                // @todo Log errors.
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console.
                println("Json Error: \(err!.localizedDescription)")
                // @todo Log errors.
            }
            
            // Execute the callback with the result data.
            completionHandler(jsonResult)
        })
        task.resume()
    }
    
    // Executes an HTTP POST request.
    static func post(path: String, jsonData: NSDictionary, completionHandler: ((NSDictionary) -> Void)!)
    {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        var err: NSError?
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonData, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            
            if (err != nil) {
                // If there is an error parsing JSON, print it to the console.
                println("Json Error: \(err!.localizedDescription)")
                // @todo Log errors.
            }
            else {
                completionHandler(jsonResult)
            }
        })
        task.resume()
    }
    
    // Executes an HTTP DELETE request.
    static func delete(path: String, completionHandler: ((NSDictionary) -> Void)!) {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        var err: NSError?
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            
            if (err != nil) {
                // If there is an error parsing JSON, print it to the console.
                println("Json Error: \(err!.localizedDescription)")
                // @todo Log errors.
            }
            else {
                completionHandler(jsonResult)
            }
        })
        task.resume()
    }
}