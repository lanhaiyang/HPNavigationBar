//
//  UIViewController+HPNavigation.h
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/25.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HPNavigation)

@property(nonatomic,strong) UIColor *hp_barBackgroundColor;

/**
 默认 <=0.01位透明
 */
@property(nonatomic,assign) CGFloat hp_barAlpha;
/**
 默认 <=0.01位透明
 */
@property(nonatomic,assign) CGFloat hp_barEdgeLineAlpha;
@property(nonatomic,assign) BOOL hp_barEdgeLine;
@property(nonatomic,assign) BOOL hp_barHidden;
@property(nonatomic,assign) BOOL hp_backInteraction;



@end
