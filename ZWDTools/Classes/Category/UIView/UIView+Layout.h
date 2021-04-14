//
//  UIView+Layout.h
//  CommonLibrary
//
//  Created by Alexi Chen on 2/28/13.
//  Copyright (c) 2013 AlexiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TZOscillatoryAnimationToBigger,
    TZOscillatoryAnimationToSmaller,
} TZOscillatoryAnimationType;


typedef NS_ENUM(NSUInteger, WBGradientColorDirection) {
    WBGradientColorDirectionTopLeftToBottomRight = 1,   //左上到右下
    WBGradientColorDirectionTopRightToBottomLeft,       //右上到左下
    WBGradientColorDirectionBottomLeftToTopRight,       //左下到右上
    WBGradientColorDirectionBottomRightToTopLeft,       //右下到左上
    WBGradientColorDirectionLeftToRight,                //左到右
    WBGradientColorDirectionTopToBottom,                //上到下
    WBGradientColorDirectionBottomToTop,                //下到上
};

@interface UIView (Layout)

@property (assign, nonatomic) CGFloat    top;
@property (assign, nonatomic) CGFloat    bottom;
@property (assign, nonatomic) CGFloat    left;
@property (assign, nonatomic) CGFloat    right;

@property (assign, nonatomic) CGFloat    x;
@property (assign, nonatomic) CGFloat    y;
@property (assign, nonatomic) CGPoint    origin;

@property (assign, nonatomic) CGFloat    centerX;
@property (assign, nonatomic) CGFloat    centerY;

@property (assign, nonatomic) CGFloat    width;
@property (assign, nonatomic) CGFloat    height;
@property (assign, nonatomic) CGSize    size;

// 添加子控件
- (void)addOwnViews;

// 配置子控件参数
- (void)configOwnViews;

//- (void)configWith:(NSMutableDictionary *)jsonDic;

// isAutoLayoutr返回YES时，使用此方法进行布局
- (void)autoLayoutSubViews;

// 是否使用自动布局
- (BOOL)isAutoLayout;

/**
 外部通过此功能进行设置，只在布局时使用

 @param rect CGRect
 */
- (void)setFrameAndLayout:(CGRect)rect;

/**
 对于一些自定义的UIView，在设置Frame后，如需要重新调整局的话
 作为所以控修改其自身内部子控件的入口
 所有的自定义View最好不要从initWithFrams里面进行设置其子View的frame,统一在些处进行设置
 */
- (void)relayoutFrameOfSubViews;

- (void)addBottomLine:(CGRect)rect;

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect;

- (NSAttributedString*)attributedStringWithAttributedString:(NSAttributedString*)attributedString insertImage:(NSArray*)imageArr  atIndex:(NSInteger)index;
#pragma mark - 设置富文本样式
- (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(TZOscillatoryAnimationType)type;

+(id)viewFromNib;

+(id)viewWithNibNamed:(NSString *)nibName;


/**
 设备view背景渐变色

 @param fromColor 起始颜色
 @param toColor 终止颜色
 @param direction 渐变方向
 */
- (void)setBackgroundGradientFromColor:(UIColor *)fromColor
                               toColor:(UIColor *)toColor
                             direction:(WBGradientColorDirection)direction;


/**
 获取渐变色背景图层

 @param fromColor 起始颜色
 @param toColor 终止颜色
 @param direction 渐变方向
 @return 渐变图层
 */
- (CAGradientLayer *)getGradientLayerFromColor:(UIColor *)fromColor
                                       toColor:(UIColor *)toColor
                                     direction:(WBGradientColorDirection)direction;

@end

@interface UIView (ShakeAnimation)

// 左右shake
- (void)shake;

@end
