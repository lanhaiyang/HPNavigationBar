//
//  SlideViewController.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/28.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "SlideViewController.h"
#import "UIViewController+HPNavigation.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)slideValue:(UISlider *)sender {
    
    self.hp_barAlpha = sender.value == 0 ? 0.01 : sender.value;
    
}


@end
