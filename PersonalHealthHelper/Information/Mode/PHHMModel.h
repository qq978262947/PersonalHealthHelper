//
//  PHHMModel.h
//  personal health helper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHHMModel : NSObject
@property (nonatomic,strong)NSNumber * ID;
@property (nonatomic,strong)NSString * name;

+(PHHMModel *)modWithDict:(NSDictionary *)dict;
//主页model
/**
 {
 "showapi_res_body" =     
 {
 list =         
 (
 {
 id = 1;
 name = "\U7efc\U5408\U8d44\U8baf";
 },
 {
 id = 2;
 name = "\U75be\U75c5\U8d44\U8baf";
 },
 {
 id = 3;
 name = "\U98df\U54c1\U8d44\U8baf";
 }
 );
 "ret_code" = 0;
 };
 "showapi_res_code" = 0;
 "showapi_res_error" = "";
 }
 */
@end
