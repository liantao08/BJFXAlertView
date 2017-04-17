//
//  ViewController.m
//  BJFXAlertView
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "BJFXAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickShow) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 100, 30);
    button.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:button];
}

//弹出提示框
- (void)clickShow {
    
    [BJFXAlertView showAlertWithTitle:@"提示" message:@"我是一个alertView"];
    
    BJFXAlertView * alertView = [BJFXAlertView AlertWithTitle:@"提示" message:@"请选择"];
    [alertView addButtonTitle:@"sure" action:^{
        
        NSLog(@"点击sure");
    }];
    
    [alertView addButtonTitle:@"cancel" action:^{
       
        NSLog(@"点击cancel");
    }];
    
    [alertView show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
