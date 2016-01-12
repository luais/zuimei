//
//  CYLMineViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLMineViewController.h"
#import "settingViewController.h"

@implementation CYLMineViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我";
//    [self.navigationController.tabBarItem setBadgeValue:@"3"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self adduser];
}

- (void)adduser{
    //背景图
    UIImageView *userBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, KScreenWidth, 150*KScreenWidth/320)];
    userBg.image = [UIImage imageNamed:@"xzzm_Me_headerBg"];
    userBg.userInteractionEnabled = YES;
    [self.view addSubview:userBg];
    //头像
    UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-(60*KScreenWidth/320)/2, 150*KScreenWidth/320/2-(60*KScreenWidth/320)/2, 60*KScreenWidth/320, 60*KScreenWidth/320)];
    photo.image = [UIImage imageNamed:@"xzzm_Me_headerPortrait"];
    [userBg addSubview:photo];
    //我喜欢的商品
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-100*KScreenWidth/320, photo.bottom+10, 200*KScreenWidth/320, 20)];
    lbl.text =@"我喜欢的商品(XX)";
    lbl.textColor = [UIColor colorWithRed:223/255.0 green:0/255.0 blue:98/255.0 alpha:1.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:12];
    [userBg addSubview:lbl];
    //设置按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(KScreenWidth-60, 15, 41*KScreenWidth/320, 41*KScreenWidth/320);
    [btn setBackgroundImage:[UIImage imageNamed:@"xzzm_Me_setupBtn"] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor redColor];
//    btn.userInteractionEnabled = YES;
    [userBg addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

}
//进入设置
- (void)click{
    settingViewController *vc = [settingViewController new];
    [self.navigationController pushViewController:vc animated:NO];
    NSLog(@"我被点击了");
}

#pragma mark - Methods

//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
//}

#pragma mark - Table view
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    [self configureCell:cell forIndexPath:indexPath];
//    
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
//}
@end
