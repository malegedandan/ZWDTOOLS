//
//  UIButton+Button.h
//  Lottery
//
//  Created by 华文河 on 2017/6/12.
//  Copyright © 2017年 hwh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ButtonEdgeInsetsStyle){
     ButtonEdgeInsetsStyleImageLeft,
     ButtonEdgeInsetsStyleImageRight,
     ButtonEdgeInsetsStyleImageTop,
     ButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (Button)

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;;

+ (UIButton *)buttonWithFrame:(CGRect)frame imageNor:(UIImage *)imageNor imageHigh:(UIImage *)imageHigh imageSel:(UIImage *)imageSel target:(id)target action:(SEL)action;

@end
