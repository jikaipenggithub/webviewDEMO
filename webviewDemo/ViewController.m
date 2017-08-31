//
//  ViewController.m
//  webviewDemo
//
//  Created by jikaipeng on 2017/8/31.
//  Copyright © 2017年 kuxuan. All rights reserved.
//

#import "ViewController.h"
#import "JSCallOCViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 30);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"JSCallOCButton" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jsCallOcButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


- (void)jsCallOcButtonAction:(id)sender
{
    JSCallOCViewController *jSCallOCViewController = [[JSCallOCViewController alloc] init];
    [self.navigationController pushViewController:jSCallOCViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
