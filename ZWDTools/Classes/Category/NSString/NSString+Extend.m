//
//  NSString+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSString+Extend.h"
#import "sys/utsname.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


@implementation NSString (Extend)


/*
 *  时间戳对应的NSDate
 */
-(NSDate *)date{
    
    NSTimeInterval timeInterval=self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

/*
 *  获取当前时间
 */
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}
/*
 *  获取当前日期
 */
+ (NSString *)getCurrentDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
/*
 *  秒转时间
 */
+ (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}
/*
 *  获取当前小时
 */
+ (NSInteger )getNowHour{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour];
    return hour;
}

/// 获取当前分钟
+ (NSInteger )getNowMinute{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger minute = [dateComponent minute];
    return minute;
}

/*
 *  获取当前时间戳
 */
+ (NSInteger )getNowTime{
    NSInteger nowTimeZone = [[NSDate date] timeIntervalSince1970];
    return  nowTimeZone;
}

/*
 *  获取当前时间戳Str
 */
+ (NSString * )getNowTimeStr{
    NSInteger nowTimeZone = [[NSDate date] timeIntervalSince1970] * 1000;
    return  [NSString stringWithFormat:@"%ld",(long)nowTimeZone];
}
/*
 *  将时间戳转换成时间
 */
+ (NSString *)getTimeFromTimestamp:(NSString *)time formatter:(NSString *)format {
    //将对象类型的时间转换为NSDate类型
    //    double time = 1504667976;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}
/*
 *  将时间转换成时间戳
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
    
}

/// 时间格式转换   yyyy年MM月dd日的日期和yyyy-MM-dd 互换
/// @param time 日期
/// @param format 格式
/// @param toFormat 转换出来的格式
+ (NSString *)timeStrSwitchTimeStr:(NSString *)time format:(NSString *)format toFormat:(NSString *)toFormat{
    NSString *timestamp = [self timeSwitchTimestamp:time andFormatter:format];
    return [self getTimeFromTimestamp:timestamp formatter:toFormat];
}


/**
 * 计算指定时间与当前的时间差
 * 参数 compareDate某一指定时间
 * 返回 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (BOOL) compareCurrentTime:(NSDate*) compareDate{
    if (!compareDate) {
        return YES;
    }
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    if (timeInterval < 60) {
        return NO;//result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        return NO;//result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) <24){
        return NO;//result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    else if((temp = temp/24) <30){
        if (temp >= 1) {
            return YES;//result = [NSString stringWithFormat:@"%ld天前",temp];
        }
        else{
            return NO;
        }
    }
    else if((temp = temp/30) <12){
        return YES;//result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        return YES;//result = [NSString stringWithFormat:@"%ld年前",temp];
    }
}
/**
 *计算开始时间后n天的时间
 *startTime 开始时间
 *day 天数
 */
+ (NSString *)endTimeForStartTime:(NSString *)startTime day:(NSString *)day formatter:(NSString *)formatter {
    NSString *startTimeStr = [NSString timeSwitchTimestamp:startTime andFormatter:formatter];
    //时间差时间戳
    NSInteger  dayDate = 24 * 60 * 60 * [day integerValue];
    NSString *endTimeStr = [NSString stringWithFormat:@"%ld",[startTimeStr integerValue]+dayDate-1];
    return [self getTimeFromTimestamp:endTimeStr formatter:formatter];
}

//传入今天的时间，返回明天的时间
+ (NSString *)getTomorrowDay:(NSDate *)aDate formatter:(NSString *)formatter{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:formatter];
    return [dateday stringFromDate:beginningOfWeek];
}


/*
 *  获取设备信息
 */
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
/*
 *  获取网络信息
 */
+ (NSString *)getNetworkType{
    
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKeyPath:@"statusBar"];
    NSString *network = @"";
    
    if (KIsiPhoneX) {
        //        iPhone X
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                network = [subview valueForKeyPath:@"originalText"];
            }
        }
    }else {
        //        非 iPhone X
        UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [foregroundView subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                switch (networkType) {
                    case 0:
                        network = @"NONE";
                        break;
                    case 1:
                        network = @"2G";
                        break;
                    case 2:
                        network = @"3G";
                        break;
                    case 3:
                        network = @"4G";
                        break;
                    case 5:
                        network = @"WIFI";
                        break;
                    default:
                        break;
                }
            }
        }
    }
    if ([network isEqualToString:@""]) {
        network = @"NO DISPLAY";
    }
    return network;
}

/*
 *  获取设备信息
 */
+ (NSString *)getDevice{
    NSDictionary * dic = @{
                           @"providersName":[NSString stringWithFormat:@"%@",[[CTTelephonyNetworkInfo alloc] init].subscriberCellularProvider.carrierName ],
                           @"networkType":[NSString stringWithFormat:@"%@",[self getNetworkType]],
                           @"model":[NSString stringWithFormat:@"%@",[self deviceVersion]],
                           @"sdkInt":[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]],
                           @"versionCode":[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]],
                           @"versionName":[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]],
                           @"windowWidth":[NSString stringWithFormat:@"%f",[UIScreen mainScreen].bounds.size.width],
                           @"windowHeight":[NSString stringWithFormat:@"%f",[UIScreen  mainScreen].bounds.size.height],
                           @"density":@"1",
                           };
    
    NSString * deviceStr =  [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    return deviceStr;
}

/*
 *  获取设备信息Str
 */
+ (NSString *)getDeviceStr{
    
    return [NSString stringWithFormat:@"system:%@,sdkInt:%@,versionName:%@,model:%@",@"ios",[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]],[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]],[NSString stringWithFormat:@"%@",[self deviceVersion]]];
}
/*
*  NSString 转 字典NSDictionary
*/
#pragma mark - NSString 转 字典NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {/*JSON解析失败*/
        return nil;
    }
    return dic;
}

/**改变指定字符字体大小*/
-(NSMutableAttributedString*)specifiedString:(NSString*)str withFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:self];
    if (str.length != 0) {
        NSRange range = [self rangeOfString:str];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

/**修改指定字符串颜色*/
- (NSMutableAttributedString*)specifiedString:(NSString*)string changeColor:(UIColor*)color{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:self];
    if (string.length == 0) string = @" ";
    NSRange range = [self rangeOfString:string];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedStr;
}

//以当前时间合成图片名称
+ (NSString *)getImageNameBaseCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".png"];
}

+ (NSString *)getVideoNameBaseCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".mp4"];
}

- (NSString *)repairNumPrecision {
    if (self.length == 0) {
        return @"0";
    }
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

+ (NSString *)arrayToJSONString:(NSArray *)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// NSDictionary 转 jsonString
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"json解析失败:%@", error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)getFirstLetter{
/**
 * **************************************** START ***************************************
 * 参考博主-庞海礁先生的一文:iOS开发中如何更快的实现汉字转拼音 http://www.olinone.com/?p=131
 * 使PPGetAddressBook对联系人排序的性能提升 3~6倍, 非常感谢!
 */
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
/**
 *  *************************************** END ******************************************
 */

    // 将拼音首字母装换成大写
    NSString *strPinYin = [[self polyphoneStringHandle:self pinyinString:pinyinString] uppercaseString];
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
}
  
        // 多音字处理
- (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}



//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}
@end
