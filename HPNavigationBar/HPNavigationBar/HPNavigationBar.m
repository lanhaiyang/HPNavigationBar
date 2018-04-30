//
//  HPNavigationBar.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/25.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "HPNavigationBar.h"

@interface HPNavigationBar()

@property (nonatomic, strong, readwrite) UIImageView *edgeLine;
@property (nonatomic, strong, readwrite) UIVisualEffectView *visualEffectView;

@end

@implementation HPNavigationBar

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
    
    if (view && [viewName isEqualToString:@"HPNavigationBar"]) {
        for (UIView *subview in self.subviews) {
            NSString *viewName = [[[subview classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
            NSArray *array = @[ @"UINavigationItemButtonView" ];
            if ([array containsObject:viewName]) {
                CGPoint convertedPoint = [self convertPoint:point toView:subview];
                CGRect bounds = subview.bounds;
                if (bounds.size.width < 80) {
                    bounds = CGRectInset(bounds, bounds.size.width - 80, 0);
                }
                if (CGRectContainsPoint(bounds, convertedPoint)) {
                    return view;
                }
            }
        }
    }
    
    NSArray *array = @[ @"UINavigationBarContentView", @"HPNavigationBar" ];
    if ([array containsObject:viewName]) {
        if (self.visualEffectView.alpha < 0.01) {
            return nil;
        }
    }
    
    if (CGRectEqualToRect(view.bounds, CGRectZero)) {
        return nil;
    }
    
    return view;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _visualEffectView.frame = self.visualEffectView.superview.bounds;
    _edgeLine.frame = CGRectMake(0, CGRectGetHeight(self.edgeLine.superview.bounds), CGRectGetWidth(self.edgeLine.superview.bounds), 0.5);
    
}

-(void)setBarTintColor:(UIColor *)barTintColor{
    [super setBarTintColor:barTintColor];
    self.visualEffectView.subviews[1].backgroundColor = barTintColor;
    
}

-(void)setShadowImage:(UIImage *)shadowImage{
    self.edgeLine.image = shadowImage;;
    if (shadowImage != nil) {
        self.edgeLine.backgroundColor = [UIColor clearColor];
    }
    else{
        self.edgeLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:77.0/255];
    }
    
}

#pragma mark - 懒加载

-(UIVisualEffectView *)visualEffectView{
    
    if (_visualEffectView == nil){
        [super setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [[self.subviews firstObject] insertSubview:_visualEffectView atIndex:0];
        
    }
    return _visualEffectView;
}

-(UIImageView *)edgeLine{
    
    if (_edgeLine == nil ) {
        [super setShadowImage:[UIImage new]];
        _edgeLine = [[UIImageView alloc] init];
        [[self.subviews firstObject] insertSubview:_edgeLine aboveSubview:self.visualEffectView];
        
    }
    return _edgeLine;
}

@end
