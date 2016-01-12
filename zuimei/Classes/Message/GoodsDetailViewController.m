//
//  GoodsDetailViewController.m
//  zuimei
//
//  Created by Aries on 15/11/9.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "TBWebViewController.h"
#import "LoginShopViewController.h"

@interface GoodsDetailViewController (){
    NSDictionary *_goodsDetail;
}

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithRed:213/255.0 green:0/255.0 blue:91/255.0 alpha:1]}];
    _goodsDetail = [[NSDictionary alloc]init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"xzzm_Commons_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    NSString *URL = [NSString stringWithFormat:@"http://yyjd.xinzhuzhang.com/m/rihankong/goods/detail?id=%@&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429622278.933702&v=1.0.9&ios=8.1&sign=c303f3090c038161662933cc950c4ee7",self.goodsID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"---response%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"goods"];
        _goodsDetail = dict;
       [self initView];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
    }];
    
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initView{
    
//    NSDictionary *imagrDic = [_goodsDetail objectAtIndex:]
     NSArray *imagArr = [_goodsDetail objectForKey:@"imageList"];

    //衣服图片
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 70, KScreenWidth-10, KScreenWidth-10)];
    img.backgroundColor = [UIColor redColor];

    NSString *url = [imagArr objectAtIndex:0];
    [img sd_setImageWithURL:[NSURL URLWithString:url]];

    [self.view addSubview:img];
    //价格按钮
    UIButton *btntext = [[UIButton alloc]initWithFrame:CGRectMake(self.view.right-120, img.bottom-10, 118, 20)];
    [btntext setBackgroundImage:[UIImage imageNamed:@"xzzm_Goods_buyBtn"] forState:UIControlStateNormal];
    [btntext setTitle:[_goodsDetail objectForKey:@"price"] forState:UIControlStateNormal];
    [btntext setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btntext.adjustsImageWhenHighlighted = NO;
    btntext.titleLabel.font = [UIFont systemFontOfSize:11];
//    btntext.titleLabel.textAlignment = NSTextAlignmentLeft;
    //文字居左
    btntext.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btntext.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btntext.userInteractionEnabled = NO;
    [self.view addSubview:btntext];
    //详情按钮跳转
    UIButton *btnDetail = [[UIButton alloc]initWithFrame:CGRectMake(btntext.width-40, 0, 40, 20)];
    [btnDetail setBackgroundColor:[UIColor orangeColor]];
    [btnDetail setTitle:@"详情" forState:UIControlStateNormal];
    [btnDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDetail.titleLabel.font = [UIFont systemFontOfSize:11];
    [btntext addSubview:btnDetail];
    [btnDetail addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    //衣服标签
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, btntext.bottom+10, KScreenWidth, 20)];
    lbl.text = [_goodsDetail objectForKey:@"title"];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor orangeColor];
    lbl.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:lbl];
    //喜欢
    UIButton *likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, lbl.bottom+10, 30, 25)];
    [likeBtn setImage:[UIImage imageNamed:@"xzzm_Goods_like"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"xzzm_Goods_liked"] forState:UIControlStateSelected];
    [self.view addSubview:likeBtn];
    //进店
    UIButton *loginShop = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-50, lbl.bottom+10, 30, 25)];
    [loginShop setImage:[UIImage imageNamed:@"xzzm_Goods_enterShop"] forState:UIControlStateNormal];
    [self.view addSubview:loginShop];
    [loginShop addTarget:self action:@selector(loginShop) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//弹出网址tb
- (void)click{
    NSLog(@"我被点击了");
    TBWebViewController *view = [TBWebViewController new];
    //网址
    NSString *urltb = [_goodsDetail objectForKey:@"url"];
    view.URLTB = urltb;
    [self.navigationController pushViewController:view animated:YES];
//    NSLog(@"web %@",request);
}

//进入店铺
- (void)loginShop{
    NSLog(@"我中招了");
    NSString *sID = [_goodsDetail objectForKey:@"sid"];
    NSArray *array =self.navigationController.viewControllers;
    UIViewController *view =[array objectAtIndex:array.count-2];
    if ([view isKindOfClass:[LoginShopViewController class]]) {
        [self.navigationController popToViewController:view animated:YES];
    }else{
        LoginShopViewController *vieww = [LoginShopViewController new];
        vieww.ShopID = sID;
        [self.navigationController pushViewController:vieww animated:YES];
    }
    
    
    
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
