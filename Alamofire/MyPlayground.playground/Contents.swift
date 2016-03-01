//: Playground - noun: a place where people can play

import XCPlayground
XCPSetExecutionShouldContinueIndefinitely(true)
import Alamofire

Alamofire.request(.GET, "http://www.baidu.com", parameters: ["foo": "bar"])
    .responseJSON { response in
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
            print("JSON: \(JSON)")
        }
}


var str = "Hello, playground"
