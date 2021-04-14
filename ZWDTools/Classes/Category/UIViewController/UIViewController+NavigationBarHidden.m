//
//  UIViewController+NavigationBarHidden.m
//  NavigationBarHidden
//
//  Created by jiangxin on 2018/11/6.
//  Copyright © 2018年 woaiyouxi0803. All rights reserved.
//

#import "UIViewController+NavigationBarHidden.h"
#import <objc/runtime.h>

@implementation UIViewController (NavigationBarHidden)

- (BOOL)shouldNavigationBarHidden{
    return [objc_getAssociatedObject(self, @selector(shouldNavigationBarHidden)) boolValue];
}

- (void)setShouldNavigationBarHidden:(BOOL)shouldNavigationBarHidden{
    objc_setAssociatedObject(self, @selector(shouldNavigationBarHidden), @(shouldNavigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

@end





