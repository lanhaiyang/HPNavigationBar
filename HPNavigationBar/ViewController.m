//
//  ViewController.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/24.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "ViewController.h"
#include "UIViewController+HPNavigation.h"
#include "SlideViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.barColor = [UIColor redColor];
//    self.hp_barEdgeLine = YES;
    self.view.backgroundColor = [UIColor grayColor];
}

- (IBAction)buttonAction:(id)sender {
    
//    self.hp_barAlpha = 0.01;
    UIStoryboard *mainStroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SlideViewController *slideViewController = [mainStroyboard instantiateViewControllerWithIdentifier:@"SlideViewController"];
    slideViewController.hp_barBackgroundColor = [UIColor clearColor];
    slideViewController.hp_barEdgeLine = YES;
    [self.navigationController pushViewController:slideViewController animated:YES];
}

- (IBAction)greenAction:(id)sender {
    
    UIStoryboard *mainStroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SlideViewController *slideViewController = [mainStroyboard instantiateViewControllerWithIdentifier:@"SlideViewController"];
    slideViewController.hp_barBackgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:slideViewController animated:YES];
    
}

- (IBAction)sliderAlper:(UISlider *)sender {
    
    self.hp_barAlpha = sender.value == 0 ? 0.01 : sender.value;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
