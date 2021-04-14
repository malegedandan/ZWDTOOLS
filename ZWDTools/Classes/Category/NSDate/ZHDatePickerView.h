//
//  ZHDatePickerView.h
//  ZHDatePickerViewDemo
//
//  Created by 曾 on 2016/12/21.
//  Copyright © 2016年 Lebronjames_zh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHDatePickerView;

@protocol ZHDatePickerViewDelegate <NSObject>

@optional
/**
 返回选择的时间字符串

 @param pickerView pickerView
 @param dateString 时间字符串
 */
- (void)pickerView:(ZHDatePickerView *)pickerView didSelectDateString:(NSString *)dateString andDateStr:(NSString *)dateStr;

@end

@interface ZHDatePickerView : UIView

@property (nonatomic, weak) id<ZHDatePickerViewDelegate> delegate;

@property(nonatomic,copy) void (^dateBlock)(NSString * showtimeString,NSString * dataString);
/**
 初始化ZHDatePickerView
 
 @param date 默认时间
 @param mode 时间显示格式
 @return ZHDatePickerView
 */
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode;

/**
 移除PickerView
 */
- (void)remove;

/**
 显示PickerView
 */
- (void)show;

@end
