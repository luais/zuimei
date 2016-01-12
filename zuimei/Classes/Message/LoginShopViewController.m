//
//  LoginShopViewController.m
//  zuimei
//
//  Created by Aries on 15/11/10.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "LoginShopViewController.h"
#import "BigPicTableViewCell.h"
#import "SmallTableViewCell.h"
#import "GoodsDetailViewController.h"

@interface LoginShopViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_itemArr;
    NSDictionary *_shopDic;
}


@end

@implementation LoginShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemArr = [[NSMutableArray alloc]initWithCapacity:0];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    //关注
    UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.frame= CGRectMake(self.view.width-90, 300, 90, 20);
    [attentionBtn setBackgroundImage:[UIImage imageNamed:@"xzzm_Shop_follow"] forState:UIControlStateNormal];
    [attentionBtn setBackgroundImage:[UIImage imageNamed:@"xzzm_Shop_unFollow"] forState:UIControlStateHighlighted];
    [self.view addSubview:attentionBtn];
    
    //返回
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"xzzm_Commons_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *URL = [NSString stringWithFormat: @"http://yyjd.xinzhuzhang.com/m/rihankong/shop/detail?id=%@&sort=0&page=0&catid=&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429620612.597404&v=1.0.9&ios=8.1&sign=4b685356a5a68fe90b3e7c9da2b149de",self.ShopID ];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"__%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"itemList"];
        [_itemArr addObjectsFromArray:array];
        NSDictionary *Dic = [responseObject objectForKey:@"shop"];
        _shopDic = Dic;
        [tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"___%@",error);
    }];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return _itemArr.count;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _itemArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic = [_itemArr objectAtIndex:indexPath.row];
    NSArray *goodsArr = [secDic objectForKey:@"goodsList"];
    //是否大图
    NSString *STR = [NSString stringWithFormat:@"%@",[secDic objectForKey:@"isBig"]];
    if ([STR isEqualToString:@"1"]) {
        BigPicTableViewCell *cell = [BigPicTableViewCell bigPicCell:tableView];
        cell.imgArr = goodsArr;
        return cell;
        
    }else {
    
        SmallTableViewCell *cell = [SmallTableViewCell smallCell:tableView];
        cell.imgArr = goodsArr;
        [cell clickbofBlock:^{
            NSDictionary *dic = [goodsArr objectAtIndex:0];
            NSString *pictureID = [dic objectForKey:@"id"];
            GoodsDetailViewController *view = [GoodsDetailViewController new];
            view.goodsID = pictureID;
            [self.navigationController pushViewController:view animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [cell clicksofBlock:^{
            NSDictionary *dic = [goodsArr objectAtIndex:1];
            NSString *pictureID = [dic objectForKey:@"id"];
            GoodsDetailViewController *view = [GoodsDetailViewController new];
            view.goodsID = pictureID;
            [self.navigationController pushViewController:view animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
        }];
        return cell;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic = [_itemArr objectAtIndex:indexPath.row];
    NSString *STR = [NSString stringWithFormat:@"%@",[secDic objectForKey:@"isBig"]];
    if ([STR isEqualToString:@"1"]) {
        return 310;
    }else{
        return KScreenWidth/2;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic = [_itemArr objectAtIndex:indexPath.row];
    NSArray *goodsArr = [secDic objectForKey:@"goodsList"];
    //是否大图
    NSString *STR = [NSString stringWithFormat:@"%@",[secDic objectForKey:@"isBig"]];
    if ([STR isEqualToString:@"1"]) {
        BigPicTableViewCell *cell = [BigPicTableViewCell bigPicCell:tableView];
        cell.imgArr = goodsArr;
        NSDictionary *dic = [goodsArr objectAtIndex:0];
        NSString *pictureID = [dic objectForKey:@"id"];
        GoodsDetailViewController *view = [GoodsDetailViewController new];
        view.goodsID = pictureID;
        [self.navigationController pushViewController:view animated:YES];
        return;
    }

}
//header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    static NSString *identifier = @"header";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identifier];
    }
    //背景
    UIImageView *backgroundImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
    backgroundImg.image = [UIImage imageNamed:@"xzzm_Me_headerBg"];
    [headerView addSubview:backgroundImg];
    //头像
    UIImageView *photoImg = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-30, 10, 60, 60)];
//    photoImg.image = [UIImage imageNamed:@"xzzm_Me_headerPortrait"];
    [photoImg sd_setImageWithURL:[NSURL URLWithString:[_shopDic objectForKey:@"shopPic"]] placeholderImage:[UIImage imageNamed:@"xzzm_Me_headerPortrait"]];
    [headerView addSubview:photoImg];
    //名称
    UILabel *nameLab  = [[UILabel alloc]initWithFrame:CGRectMake(0, photoImg.bottom+10, KScreenWidth, 10)];
//    nameLab.text = @"纳斯达克了；范进 阿萨德减肥看";
    nameLab.text = [_shopDic objectForKey:@"name"];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:11];
    [headerView addSubview:nameLab];
    //描述相符
    UILabel *miaoshuLab = [[UILabel alloc]initWithFrame:CGRectMake(50, nameLab.bottom+10, KScreenWidth-100, 15)];
    NSString *score = [_shopDic objectForKey:@"item_score"];
    miaoshuLab.text = [NSString stringWithFormat:@"描述相符:%@与同行持平",score];
    miaoshuLab.textAlignment = NSTextAlignmentCenter;
    miaoshuLab.font = [UIFont systemFontOfSize:11];
    miaoshuLab.backgroundColor  = [UIColor orangeColor];
    miaoshuLab.layer.cornerRadius = 5;
    miaoshuLab.layer.masksToBounds = YES;
    [headerView addSubview:miaoshuLab];
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

@end
