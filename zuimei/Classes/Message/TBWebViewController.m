//
//  TBWebViewController.m
//  zuimei
//
//  Created by Aries on 15/11/9.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "TBWebViewController.h"
#import "GoodsDetailViewController.h"

@interface TBWebViewController ()

@end

@implementation TBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//    NSURL* url = [NSURL URLWithString:@"http://a.m.taobao.com/i523870558460.htm"];
    NSURL *url = [NSURL URLWithString:self.URLTB];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    

    [self.view addSubview:_web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
