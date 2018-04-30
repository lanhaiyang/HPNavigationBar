//
//  ModelPushViewController.m
//  HPNavigationBar
//
//  Created by 何鹏 on 2018/4/27.
//  Copyright © 2018年 何鹏. All rights reserved.
//

#import "ModelPushViewController.h"

@interface ModelPushViewController ()



@end

@implementation ModelPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)podButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
