//
//  UIView+Layout.m
//  CommonLibrary
//
//  Created by Alexi Chen on 2/28/13.
//  Copyright (c) 2013 AlexiChen. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)
@dynamic top;
@dynamic bottom;
@dynamic left;
@dynamic right;

@dynamic width;
@dynamic height;

@dynamic size;

@dynamic x;
@dynamic y;
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (id)init
{
    if (self = [self initWithFrame:CGRectZero]) {
        
        if (![self isAutoLayout])
        {
            [self addOwnViews];
            [self configOwnViews];
        }
        else
        {
            [self autoLayoutSubViews];
        }
        
    }
    return self;
}

- (BOOL)isAutoLayout
{
    return NO;
}

- (void)autoLayoutSubViews
{
    
}

- (void)addOwnViews
{
    // 添加自己的控件
}

- (void)configOwnViews
{
    // 初始化控件的值
}

//- (void)configWith:(NSMutableDictionary *)jsonDic
//{
//    
//}

- (void)setFrameAndLayout:(CGRect)rect
{
    self.frame = rect;
    if (self.bounds.size.width != 0 && self.bounds.size.height != 0)
    {
        [self relayoutFrameOfSubViews];
    }
}
- (void)relayoutFrameOfSubViews
{
    // do nothing here
}

- (void)addBottomLine:(CGRect)rect
{
    [self addBottomLine:[UIColor lightGrayColor] inRect:rect];
}

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
   	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}


#pragma mark - 设置富文本样式
- (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay
{
    // 定义要显示的文字内容
    NSString * string = [stringArray componentsJoinedByString:@""];//拼接传入的字符串数组
    // 通过要显示的文字内容来创建一个带属性样式的字符串对象
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++)
    {
        // 将某一范围内的字符串设置样式
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


#pragma mark - label 添加图片
-(NSAttributedString*)attributedStringWithAttributedString:(NSAttributedString*)attributedString insertImage:(NSArray*)imageArr  atIndex:(NSInteger)index
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithAttributedString:attributedString];
    
    for ( int i = 0; i<imageArr.count ; i++) {
        UIImage * image = imageArr[i];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
        textAttachment.image = image;
        if (i == 1) {
            textAttachment.bounds = CGRectMake(5*(i+1), 0, self.frame.size.height*4/5*2, self.frame.size.height*4/5);
        }else{
            textAttachment.bounds = CGRectMake(5*(i+1), 0, self.frame.size.height*4/5, self.frame.size.height*4/5);
        }
        
        NSAttributedString *att_str = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attstr insertAttributedString:att_str atIndex:index+i];
    }
    return attstr.copy;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(TZOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == TZOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == TZOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}


- (void)setBackgroundGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(WBGradientColorDirection)direction {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    gradientLayer.frame = self.bounds;
    
    switch (direction) {
        case WBGradientColorDirectionTopLeftToBottomRight: {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
        }
            break;
        case WBGradientColorDirectionTopRightToBottomLeft: {
            gradientLayer.startPoint = CGPointMake(1, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
        case WBGradientColorDirectionBottomLeftToTopRight: {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case WBGradientColorDirectionBottomRightToTopLeft: {
            gradientLayer.startPoint = CGPointMake(1, 1);
            gradientLayer.endPoint = CGPointMake(0, 0);
        }
            break;
        case WBGradientColorDirectionLeftToRight: {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case WBGradientColorDirectionTopToBottom: {
            gradientLayer.startPoint = CGPointMake(0.5, 0);
            gradientLayer.endPoint = CGPointMake(0.5, 1);
        }
            break;
        case WBGradientColorDirectionBottomToTop: {
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
        }
            break;
    }
    
    if (self.layer.sublayers.count > 0 && [self.layer.sublayers.firstObject isKindOfClass:[CAGradientLayer class]]) {
        [self.layer.sublayers.firstObject removeFromSuperlayer];
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
}



- (CAGradientLayer *)getGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(WBGradientColorDirection)direction {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    
    switch (direction) {
        case WBGradientColorDirectionTopLeftToBottomRight: {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
        }
            break;
        case WBGradientColorDirectionTopRightToBottomLeft: {
            gradientLayer.startPoint = CGPointMake(1, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
        case WBGradientColorDirectionBottomLeftToTopRight: {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case WBGradientColorDirectionBottomRightToTopLeft: {
            gradientLayer.startPoint = CGPointMake(1, 1);
            gradientLayer.endPoint = CGPointMake(0, 0);
        }
            break;
        case WBGradientColorDirectionLeftToRight: {
            gradientLayer.startPoint = CGPointMake(0, 0.5);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case WBGradientColorDirectionTopToBottom: {
            gradientLayer.startPoint = CGPointMake(0.5, 0);
            gradientLayer.endPoint = CGPointMake(0.5, 1);
        }
            break;
        case WBGradientColorDirectionBottomToTop: {
            gradientLayer.startPoint = CGPointMake(0.5, 1);
            gradientLayer.endPoint = CGPointMake(0.5, 0);
        }
            break;
    }
    
    return gradientLayer;
}

@end


@implementation UIView (ShakeAnimation)

- (void)shake
{
    CGFloat t =4.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    self.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}


+(id)viewFromNib
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    return [views firstObject];
}

+(id)viewWithNibNamed:(NSString *)nibName
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    return [views firstObject];
}
@end
