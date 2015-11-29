//
//  ViewController.m
//  转盘
//
//  Created by Jusive on 15/11/29.
//  Copyright © 2015年 Jusive. All rights reserved.
//

#import "ViewController.h"
#import "Circle.h"
@interface ViewController ()
@property (nonatomic,weak)Circle *circle;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    Circle *circle = [Circle circle];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    circle.center = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    [self.view addSubview:circle];
    self.circle = circle;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
