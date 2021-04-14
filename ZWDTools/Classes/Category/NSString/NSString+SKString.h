//
//  NSString+SKString.h
//  WuWuTexiForDriver
//
//  Created by youngxiansen on 15/9/17.
//  Copyright (c) 2015年 AQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  字符串的一些判断
 */
@interface NSString (SKString)
+(CGSize)sizeofString:(NSString*)str withMaxSize:(CGSize)maxSize withFont:(UIFont*)font;

+(CGSize)sizeofString:(NSString*)str withMaxWidth:(CGFloat)width withFont:(UIFont*)font paragraphStyle:(NSParagraphStyle *)paragraphStyle;

/**
 *  计算文字的高度
 *  @param str   要显示的字符串
 *  @param width 屏幕上显示字符串的宽度
 *  @param font  定义字符串的字体 这个必须和Xib里字体保持一致
 */
+(CGFloat)sizeofString:(NSString*)str withMaxWidth:(CGFloat)width withFont:(UIFont*)font;

/**
 *  将日期转成字符串
 *  @param date      NSDate类型
 *  @param formotStr 时间的任意格式,HH大写表示24小时制
 */
+(NSString *)transfromDateToString:(NSDate *)date withformotStr:(NSString *)formotStr;


/**
 *  将时间戳转成日期字符串
 *  @param timeStr   时间戳
 *  @param formatStr 日期字符串的格式
 */
+(NSString *)transfromTimeStrToString:(NSString *)timeStr formatStr:(NSString *)formatStr;


/** 以后存储调用这个方法--注意只存字符串 */
+(void)storeObject:(id)object forKey:(NSString*)keyName;

/** 以后存储调用这个方法--注意只存字符串 */
+(void)storeObjectAll:(id)object forKey:(NSString*)keyName;

+(NSMutableDictionary *)getAllObjectWithKey:(NSString*)keyName;

+(NSMutableArray *)getAllObjectArrWithKey:(NSString*)keyName;

/** 以后存获取值调用这个方法 */
+(NSString*)getObjectWithKey:(NSString*)key;

/**
 *  判断字符串是否为nil或者nil
 */
+(BOOL)isNilOrEmptyString:(NSString*)string;

#pragma mark --正在判断--

/**
 *  判断字符串是否是纯数字 YES纯数字NO不是纯数字
 */
+(BOOL)isAllNumWithString:(NSString *)string;

/** 判断手机号是否合法YES合法NO不合法 */
+(BOOL)isValidateMobileString:(NSString *)mobile;

/** 判断邮箱是否合法 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 *  判断字符串中是否有数字YES有数字NO没有数字
 *  @return YES有数字NO没有数字
 */
+(BOOL)isStringHaveNumberWithStr:(NSString*)str;

/** 判断身份证号是否合法YES合法NO不合法 */
+(BOOL)isValidateIdentityCard:(NSString *)identityCard;

/** 判断车牌号是否合法YES合法NO不合法 */
+ (BOOL)isValidateCarNumber:(NSString *)carNo;

/** 判断密码 只能输入字母和数字 */
+(BOOL)isValidatePassword:(NSString *)passWord;

/** 判断银行卡号是否合法YES合法NO不合法 */
+(BOOL)isValidateBankCardNumber:(NSString *)bankCardNumber;


/** 判断url是否有效 */
+(BOOL)isValidateUrlStr:(NSString*)str;

/** 必须输入2-8个汉字 */
+ (BOOL)isValidateNickname:(NSString *)nickname;

/**
 * 判断字符串是否包含特殊字符
 * 可以输入字符和数字,汉字
 */
+ (BOOL)isContainsSpecialChar:(NSString*)str;
+(NSString*)stringFromObj:(id)obj;
- (NSString *)MD5;
- (NSString *)md5wzt:(NSString *)str;

+ (NSString *)safeString:(NSString *)src;

+ (NSString *)safeNumString:(NSString *)str;
@end
