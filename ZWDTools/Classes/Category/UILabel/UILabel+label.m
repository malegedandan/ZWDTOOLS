//
//  UILabel+label.m
//  WBX
//
//  Created by Kobe on 2020/1/15.
//  Copyright © 2020 xiaomi. All rights reserved.
//

#import "UILabel+label.h"

@implementation UILabel (label)

+ (UILabel *)createLableFrame:(CGRect)frame
                     andFont:(int)font
                    andColor:(UIColor *)color
          andNSTextAlignment:(NSTextAlignment)alignment
                     andText:(NSString *)text{
   
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = alignment;
    label.text = text;
    return label;
}

@end
