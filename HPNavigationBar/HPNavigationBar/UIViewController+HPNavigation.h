//
//  UIViewController+HPNavigation.h
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/25.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HPNavigation)


/**
 设置背景颜色
 */
@property(nonatomic,strong) UIColor *hp_barBackgroundColor;

/**
 默认 <=0.01位透明 **注意** 透视不是0 而是0.01
 */
@property(nonatomic,assign) CGFloat hp_barAlpha;

/**
 默认 <=0.01位透明 **注意** 透视不是0 而是0.01
 */
@property(nonatomic,assign) CGFloat hp_barEdgeLineAlpha;

/**
 navigation 底部的 线是否显示
 */
@property(nonatomic,assign) BOOL hp_barEdgeLine;

/**
 navigation 是否隐藏
 */
@property(nonatomic,assign) BOOL hp_barHidden;

/**
 navigation 返回键 是否可以交换
 */
@property(nonatomic,assign) BOOL hp_backInteraction;



@end
