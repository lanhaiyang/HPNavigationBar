//
//  HPNavigationController.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/25.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "HPNavigationController.h"
#import "HPNavigationBar.h"
#import "UIViewController+HPNavigation.h"

@interface HPNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong,readonly) HPNavigationBar *navigationBar;
@property (nonatomic, strong) UIVisualEffectView *fromVisualEffectView;
@property (nonatomic, strong) UIVisualEffectView *toVisualEffectView;
@property (nonatomic, strong) UIImageView *fromEdgeLine;
@property (nonatomic, strong) UIImageView *toEdgeLine;

@end

@implementation HPNavigationController

@dynamic navigationBar;

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    if (self = [super initWithNavigationBarClass:[HPNavigationBar class] toolbarClass:nil]) {
        self.viewControllers = @[ rootViewController ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationDelegate];
    [self.navigationBar setShadowImage:[UINavigationBar appearance].shadowImage];
    [self.navigationBar setTranslucent:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)navigationDelegate{
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)updateNavigationBarForController:(UIViewController *)vc{
    self.navigationBar.visualEffectView.alpha = vc.hp_barAlpha;
    self.navigationBar.edgeLine.alpha = vc.hp_barEdgeLineAlpha;
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.barTintColor = vc.hp_barBackgroundColor;
    
    
    
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
    if (coordinator) {
        UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *to = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        
        
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            BOOL shouldFake = to == viewController && (![from.hp_barBackgroundColor.description  isEqual:to.hp_barBackgroundColor.description] || ABS(from.hp_barAlpha - to.hp_barAlpha) > 0.1);
            
            if (shouldFake) {
                [UIView setAnimationsEnabled:NO];
                self.navigationBar.visualEffectView.alpha = 0;
                self.navigationBar.edgeLine.alpha = 0;
                
                self.fromVisualEffectView.subviews[1].backgroundColor = from.hp_barBackgroundColor;
                self.fromVisualEffectView.alpha = from.hp_barAlpha == 0 ? 0.01:from.hp_barAlpha;
                if (from.hp_barAlpha == 0) {
                    self.fromVisualEffectView.subviews[1].alpha = 0.01;
                }
                
                self.fromVisualEffectView.frame = [self fakeBarFrameForViewController:from];
                [from.view addSubview:_fromVisualEffectView];
                self.fromEdgeLine.alpha = from.hp_barEdgeLineAlpha;
                self.fromEdgeLine.frame = [self edgeLineFrameForView:self.fromVisualEffectView.frame];
                [from.view addSubview:_fromEdgeLine];
                
            
                self.toVisualEffectView.subviews[1].backgroundColor = to.hp_barBackgroundColor;
                self.toVisualEffectView.alpha = to.hp_barAlpha == 0 ? 0.01:to.hp_barAlpha;
                self.toVisualEffectView.frame = [self fakeBarFrameForViewController:to];
                [to.view addSubview:_toVisualEffectView];
                self.toEdgeLine.alpha = to.hp_barEdgeLineAlpha;
                self.toEdgeLine.frame = [self edgeLineFrameForView:self.toVisualEffectView.frame];
                [to.view addSubview:_toEdgeLine];
                
//                NSLog(@"from = %lf to = %lf",from.hp_barEdgeLineAlpha,to.hp_barEdgeLineAlpha);
                
                [UIView setAnimationsEnabled:YES];
                
                
            }
            else{
                [self updateNavigationBarForController:viewController];
                
            }
            
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            if (context.isCancelled) {
                [self updateNavigationBarForController:from];
            } else {
                // 当 present 时 to 不等于 viewController
                [self updateNavigationBarForController:viewController];
            }
            
            if (to == viewController) {
                [self closeOverBar];
                [self freeOverBar];
            }
            
        }];
        
        
    } else {
        
        [self updateNavigationBarForController:viewController];
        
    }
    
}

- (CGRect)  fakeBarFrameForViewController:(UIViewController *)vc {
    CGRect frame = [self.navigationBar.visualEffectView convertRect:self.navigationBar.visualEffectView.frame toView:vc.view];
    frame.origin.x = vc.view.frame.origin.x;
    return frame;
}

-(CGRect) edgeLineFrameForView:(CGRect )fakeBarFrame{
    
    
    CGRect frame = CGRectMake(fakeBarFrame.origin.x, fakeBarFrame.origin.y+fakeBarFrame.size.height, fakeBarFrame.size.width, 0.5);
    
    return frame;
}

-(void)freeOverBar{
    
    _fromVisualEffectView = nil;
    _toVisualEffectView = nil;
    _fromEdgeLine = nil;
    _toEdgeLine = nil;
    
}

-(void)closeOverBar{
    
    [_fromVisualEffectView removeFromSuperview];
    [_toVisualEffectView removeFromSuperview];
    [_fromEdgeLine removeFromSuperview];
    [_toEdgeLine removeFromSuperview];
    
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.viewControllers.count > 1) {
        return self.topViewController.hp_backInteraction;
    }
    return YES;
}

#pragma mark - 懒加载

-(UIVisualEffectView *)fromVisualEffectView{
    
    if (_fromVisualEffectView == nil) {
        _fromVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    }
    return _fromVisualEffectView;
}

-(UIVisualEffectView *)toVisualEffectView{
    
    if (_toVisualEffectView == nil) {
        _toVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    }
    return _toVisualEffectView;
}

-(UIImageView *)fromEdgeLine{
    
    if (_fromEdgeLine) {
        _fromEdgeLine = [[UIImageView alloc] initWithImage:self.navigationBar.edgeLine.image];
        _fromEdgeLine.backgroundColor = self.navigationBar.edgeLine.backgroundColor;
    }
    return _fromEdgeLine;
}

-(UIImageView *)toEdgeLine{
    
    if (_toEdgeLine == nil) {
        _toEdgeLine = [[UIImageView alloc] initWithImage:self.navigationBar.edgeLine.image];
        _toEdgeLine.backgroundColor = self.navigationBar.edgeLine.backgroundColor;
    }
    return _toEdgeLine;
}

@end
