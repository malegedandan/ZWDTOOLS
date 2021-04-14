//
//  NSString+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSDictionary+RSA.h"
#import "DPRSA.h"
#import "Base64.h"

@implementation NSDictionary (RSA)


/**
 *  32位MD5加密
 */
-(NSString *)rsa{
    DPRSA *rsa = [[DPRSA alloc] init];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    rsa.public_key = [data base64EncodedStringWithWrapWidth:0];
    ;
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  [rsa rsaEncryptString:jsonString];
}
/**
 *  32位MD5加密
 */
-(NSString *)rsa1{
    DPRSA *rsa = [[DPRSA alloc] init];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    rsa.public_key = [data base64EncodedStringWithWrapWidth:0];
    NSArray * keyArr =  [self allKeys];
    NSString * str = @"{";
    for (NSString * obj in keyArr) {
        str = [NSString stringWithFormat:@"%@%@:%@,",str,obj,self[obj]];
    }
    str = @"{ name: hunter1861, password: 123456 }";
    return  [rsa rsaEncryptString:str];
}




@end
