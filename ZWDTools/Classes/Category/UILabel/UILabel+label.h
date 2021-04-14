//
//  UILabel+label.h
//  WBX
//
//  Created by Kobe on 2020/1/15.
//  Copyright © 2020 xiaomi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (label)

+ (UILabel *)createLableFrame:(CGRect)frame
           andFont:(int)font
          andColor:(UIColor *)color
andNSTextAlignment:(NSTextAlignment)alignment
           andText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
