//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIFont;
@class UIColor;

@interface NSString (Extend)
/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;
/*
 *  获取当前时间
 */
+(NSString*)getCurrentTimes;
/*
 *  获取当前日期
 */
+ (NSString *)getCurrentDay;
/*
 *  秒转时间
 */
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;
/*
 *  获取当前小时
 */
+ (NSInteger )getNowHour;

/// 获取当前分钟
+ (NSInteger )getNowMinute;

/*
 *  获取当前时间戳
 */
+ (NSInteger )getNowTime;
/*
 *  获取当前时间戳Str
 */
+ (NSString * )getNowTimeStr;
/*
 *  将时间戳转换成时间
 */
+ (NSString *)getTimeFromTimestamp:(NSString *)time formatter:(NSString *)format;
/*
 *  将时间转换成时间戳
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/// 时间格式转换   yyyy年MM月dd日的日期和yyyy-MM-dd 互换
/// @param time 日期
/// @param format 格式
/// @param toFormat 转换出来的格式
+ (NSString *)timeStrSwitchTimeStr:(NSString *)time format:(NSString *)format toFormat:(NSString *)toFormat;


/**
 * 计算指定时间与当前的时间差
 * 参数 compareDate某一指定时间
 * 返回 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 * 
 */

+ (BOOL) compareCurrentTime:(NSDate*) compareDate;
/**
 *计算开始时间后n天的时间
 *startTime 开始时间
 *day 天数
 */
+ (NSString *)endTimeForStartTime:(NSString *)startTime day:(NSString *)day formatter:(NSString *)formatter;

//传入今天的时间，返回明天的时间
+ (NSString *)getTomorrowDay:(NSDate *)aDate formatter:(NSString *)formatter;

/*
 *  获取设备信息
 */
+ (NSString*)deviceVersion;
/*
*  获取设备信息Str
*/
+ (NSString *)getDeviceStr;

/*
 *  获取网络信息
 */
+ (NSString *)getNetworkType;
/*
 *  获取设备信息
 */
+ (NSString *)getDevice;

/*
*  NSString 转 字典NSDictionary
*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**改变指定字符字体大小*/
-(NSMutableAttributedString*)specifiedString:(NSString*)str withFont:(UIFont *)font;

/**修改指定字符串颜色*/
- (NSMutableAttributedString*)specifiedString:(NSString*)string changeColor:(UIColor*)color;

//以当前时间合成图片名称
+ (NSString *)getImageNameBaseCurrentTime;
//以当前时间合成视频名称
+ (NSString *)getVideoNameBaseCurrentTime;
/*
 * 修复精度缺失问题
 */
- (NSString *)repairNumPrecision;

/**
 数组转json
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;

// 字典转json
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json;

- (NSString *)getFirstLetter;

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;
@end
