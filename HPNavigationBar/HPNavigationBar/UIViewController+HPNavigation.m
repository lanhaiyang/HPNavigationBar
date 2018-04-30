//
//  UIViewController+HPNavigation.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/25.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "UIViewController+HPNavigation.h"
#import "HPNavigationController.h"
#import <objc/runtime.h>


@implementation UIViewController (HPNavigation)


-(UIColor *)hp_barBackgroundColor{
    
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    return [UINavigationBar appearance].barTintColor;
}

-(void)setHp_barBackgroundColor:(UIColor *)hp_barBackgroundColor{
    objc_setAssociatedObject(self, @selector(hp_barBackgroundColor), hp_barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePage];
}

-(CGFloat)hp_barAlpha{
    
    id obj = objc_getAssociatedObject(self, _cmd);

    if([obj floatValue] == 0){
        return 1;
    }
    else if ([obj floatValue] <= 0.01) {
        return 0;
    }
    
    return [obj floatValue];
}

-(void)setHp_barAlpha:(CGFloat)hp_barAlpha{
    
    objc_setAssociatedObject(self, @selector(hp_barAlpha), @(hp_barAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePage];
}

-(void)setHp_barEdgeLineAlpha:(CGFloat)hp_barEdgeLineAlpha{
    
    objc_setAssociatedObject(self, @selector(hp_barEdgeLineAlpha), @(hp_barEdgeLineAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)hp_barEdgeLineAlpha{
    
    id obj = objc_getAssociatedObject(self, _cmd);
    
    if([obj floatValue] == 0){
        return 1;
    }
    else if ([obj floatValue] <= 0.01) {
        return 0;
    }
    
    return [obj floatValue];
}

-(BOOL)hp_barEdgeLine{
    
    id obj = objc_getAssociatedObject(self, _cmd);
    
    return obj ? [obj boolValue] :NO;
    
}

-(void)setHp_barEdgeLine:(BOOL)hp_barEdgeLine{
    
    objc_setAssociatedObject(self, @selector(hp_barEdgeLine), @(hp_barEdgeLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (hp_barEdgeLine == YES) {
        self.hp_barEdgeLineAlpha = 0.01;
    }
    else{
        self.hp_barEdgeLineAlpha = 1;
    }
    
}

-(void)updatePage{
    
    if (self.navigationController && [self.navigationController isKindOfClass:[HPNavigationController class]]) {
        HPNavigationController *nav = (HPNavigationController *)self.navigationController;
        [nav updateNavigationBarForController:self];
    }
    
}

-(BOOL)hp_barHidden{
    
    id obj = objc_getAssociatedObject(self, _cmd);
    
    return obj ? [obj boolValue] :YES;
}

-(void)setHp_barHidden:(BOOL)hp_barHidden{
    
    if (hp_barHidden) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.titleView = [UIView new];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.titleView = nil;
    }
    
    objc_setAssociatedObject(self, @selector(hp_barHidden), @(hp_barHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(BOOL)hp_backInteraction{
    
    id obj = objc_getAssociatedObject(self, _cmd);
    
    return obj ? [obj boolValue] :YES;
}

-(void)setHp_backInteraction:(BOOL)hp_backInteraction{
    
    objc_setAssociatedObject(self, @selector(hp_backInteraction), @(hp_backInteraction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePage];
}

@end
