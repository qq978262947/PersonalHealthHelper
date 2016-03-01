//
//  ShowAPI_SDK.swift
//  ShowAPI_demo
//
//  Created by 兰文栋 on 16/1/8.
//  Copyright © 2016年 showapi. All rights reserved.
//

import Foundation
import Alamofire

@objc class ShowApiRequest:NSObject {
    //showAPI申请的appId
    private let appId:String?
    //showAPI申请的secret
    private let secret:String?
    //超时时间（毫秒）
    private let timeout:Int?
    //接口地址
    private let url:String?
    
    
    //请求实例，持有以实现取消操作
    private var request:Request?

    //构造方法
   @objc init(url:String,appId:String,secret:String,timeout:Int=5000){
        self.appId=appId
        self.secret=secret
        self.timeout=timeout
        self.url=url
    }

    //发送请求
    @objc func post(parameters: [String: AnyObject]? = nil,fileParameters:[String:NSURL]?=nil,callback:(NSDictionary)->Void){
        
        if let fileParameters=fileParameters{
          Alamofire.upload(
                .POST,
                self.url!,
                multipartFormData: { multipartFormData in
                    for(key,value) in fileParameters{
                        multipartFormData.appendBodyPart(fileURL:value,name: key);
//                        multipartFormData.appendBodyPart(data: NSData(contentsOfURL: value)!, name: key)
                    }
                    let params=self.createSecretParam(parameters)
                    for(key,value) in params{
                        multipartFormData.appendBodyPart(data: "\(value)".dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                    }
                },
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .Success(let upload, _, _):
                      self.request =  upload.responseJSON { response in
                            self.response(response, callback: callback)
                            
                        }
                    case .Failure(let encodingError):
                        print(encodingError)
                    
                        self.error("\(encodingError)",callback:callback)
                    }
                }
            )
        }else{
            self.request =  Alamofire.request(.POST, self.url!,parameters: self.createSecretParam(parameters)).responseJSON(){response in
               self.response(response, callback: callback)
            }
        }
        
    }
    
    //取消请求，只能取消最后一个发送的请求
    @objc func cancel(){
        if let request=self.request{
            request.cancel()
        }
    }
    
    private func createSecretParam(parameters: [String: AnyObject]? = nil) -> [String: AnyObject]{
        let formatter=NSDateFormatter()
        formatter.dateFormat="yyyyMMddHHmmss"
        var re:[String: AnyObject]=[
            "showapi_appid":self.appId!,
            "showapi_timestamp":formatter.stringFromDate(NSDate())
        ]
        
        if let parameters=parameters{
            for (key, value) in parameters {
                re[key]=value
            }
        }
        

        let sortKeys=Array(re.keys).sort(<)
        var temp=""
        for key in sortKeys{
            temp+=key+"\(re[key]!)"
        }
        

        temp+=self.secret!
        
        re["showapi_sign"]=ShowApiRequest.md5(temp)
           return re
    }
    
    private func response(response:Response<AnyObject, NSError>,callback:(NSDictionary)->Void){
        if(response.result.isSuccess){
            callback(response.result.value as! NSDictionary)
            
        }else{
           print(response.result.error)
            self.error(response.result.error?.description,callback:callback)
        }
        
    }
    private func error(error:String?=nil,callback:(NSDictionary)->Void){
        let re:NSDictionary=["showapi_res_code":-1,"showapi_res_error":error!]
        callback(re)
        
    }
    
    
    static func md5(str: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
    
    
    
    
}
