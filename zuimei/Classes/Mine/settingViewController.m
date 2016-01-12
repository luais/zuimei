//
//  settingViewController.m
//  zuimei
//
//  Created by Aries on 15/11/2.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "settingViewController.h"
#import "AboutViewController.h"
#import "HandpickTableViewController.h"
#import "ShopViewController.h"

@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"xzzm_Commons_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //意见
    UIButton *ideaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ideaBtn.frame = CGRectMake(10, 70, KScreenWidth-20, 46*KScreenWidth/320);
    [ideaBtn setBackgroundImage:[UIImage imageNamed:@"xzzm_Settings_feedbackBtn" ] forState:UIControlStateNormal];
    [self.view addSubview:ideaBtn];
    [ideaBtn addTarget:self action:@selector(clickIdea) forControlEvents:UIControlEventTouchUpInside];
    //清理缓存
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBtn.frame = CGRectMake(10, ideaBtn.bottom+10, KScreenWidth-20, 46*KScreenWidth/320) ;
    [cleanBtn setBackgroundImage:[UIImage imageNamed:@"xzzm_Settings_cleanBtn"] forState:UIControlStateNormal];
    [self.view addSubview:cleanBtn];
    [cleanBtn addTarget:self action:@selector(clickClean) forControlEvents:UIControlEventTouchUpInside];
    //关于
    UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutBtn.frame = CGRectMake(10, cleanBtn.bottom+10, KScreenWidth-20, 46*KScreenWidth/320);
    [aboutBtn setBackgroundImage:[UIImage imageNamed:@"xzzm_Settings_aboutBtn"] forState:UIControlStateNormal];
    [self.view addSubview:aboutBtn];
    [aboutBtn addTarget:self action:@selector(clickAbout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickIdea{
    NSLog(@"我被点击");
    HandpickTableViewController *tab = [HandpickTableViewController new];
    [self.navigationController pushViewController:tab animated:YES];
}

- (void)clickClean{
    NSLog(@"我也被点击了");
    ShopViewController *shop = [[ShopViewController alloc]init];
    [self.navigationController pushViewController:shop animated:NO];
}

- (void)clickAbout{
    
    AboutViewController *about = [AboutViewController new];
    [self.navigationController pushViewController:about animated:YES];
    NSLog(@"我同样被点击了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
