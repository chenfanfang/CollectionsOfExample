//
//  UIView+FFExtension.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "UIView+FFExtension.h"
#import <objc/runtime.h>

@implementation UIView (FFExtension)

/// 添加属性

// 定义关联的key
static const char *key_didAddsubView = "didAddsubView";

- (void (^)())didAddsubView {
    return objc_getAssociatedObject(self, key_didAddsubView);
}

- (void)setDidAddsubView:(void (^)())didAddsubView {
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, key_didAddsubView, didAddsubView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



/// 黑魔法交换方法

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //进行方法交换，目的：让UIView addSubView的时候可以被监听到
        Class class_UIView = NSClassFromString(@"UIView");
        
        SEL originalSelector = @selector(addSubview:);
        SEL swizzledSelector = @selector(swizzlingAddSubview:);
        
        Method originalMethod = class_getInstanceMethod(class_UIView, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class_UIView, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class_UIView,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class_UIView,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


- (void)swizzlingAddSubview:(UIView *)view {
    
    [self swizzlingAddSubview:view];
    
    if (self.didAddsubView) {
        self.didAddsubView();
    }
}

@end
