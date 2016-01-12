//
//  CYLSameFityViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLSameFityViewController.h"
#import "CYLTabBarController.h"
#import "CYLDetailsViewController.h"

@interface CYLSameFityViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_shopTableView;
    NSMutableArray *_shopArray;
    MBProgressHUD *HUD;
}


@end


@implementation CYLSameFityViewController

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"同城";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _shopArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    [self.view addSubview:scrollView];
    self.scroll = scrollView;
    [self addhead];
    [self initTableView];
    
    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
//    HUD.delegate =self;
    HUD.dimBackground = YES;
    [HUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:GUANZHUURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hide:YES];
//                NSLog(@"=====JSON: %@", responseObject);
        NSArray *array = [responseObject objectForKey:@"shopList"];
        [_shopArray addObjectsFromArray:array];
        [_shopTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)addhead{
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 129*KScreenWidth/320)];
    _img.image = [UIImage imageNamed:@"xzzm_MyStreet_topBg"];
//    [_img setUserInteractionEnabled:YES];
    [self.scroll addSubview:_img];
    
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(25, 65, 100, 20)];
    lbl.text = @"共关注了xx个店铺";
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textColor = [UIColor colorWithRed:223/255.0 green:0/255.0 blue:98/255.0 alpha:1.0];
    [self.img addSubview:lbl];
    //小编精选
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-(91*KScreenWidth/320)/2, _img.bottom,91*KScreenWidth/320, 21*KScreenWidth/320)];
    img1.image = [UIImage imageNamed:@"xzzm_MyStreet_recommendLabel"];
    self.img1 = img1;
    [self.scroll addSubview:img1];
    
}

- (void)initTableView{
    _shopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.img1.bottom+10, KScreenWidth, 190*15*KScreenWidth/320)];
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;
    _shopTableView.scrollEnabled =NO;
//    _shopTableView.backgroundColor = [UIColor clearColor];
    _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scroll addSubview:_shopTableView];
    self.scroll.contentSize =CGSizeMake(0, _shopTableView.bottom+50*KScreenWidth/320);
    

    
}

#pragma mark - Methods

//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
//}


#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dataDic = [_shopArray objectAtIndex:indexPath.row];
    NSLog(@"====%@",dataDic);
//    吊铺
    NSDictionary *shopDic =[dataDic objectForKey:@"shop"];
    //sizhangtupian
    NSArray *imgArr =[dataDic objectForKey:@"goodsList"];
    
    //店铺名
    NSDictionary *nameDic = [dataDic objectForKey:@"name"];
//    [self configureCell:cell forIndexPath:indexPath];
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, KScreenWidth-20, 170*KScreenWidth/320)];
    view.image = [UIImage imageNamed:@"xzzm_Street_sliderBg"];
    view.userInteractionEnabled = YES;
    [cell addSubview:view];
    //店铺
    UIImageView *shopImg = [[UIImageView alloc]initWithFrame:CGRectMake(view.left+5, view.top+5, view.height/4, view.height/4)];
//    shopImg.image = [UIImage imageNamed:@"yema18"];
    [shopImg sd_setImageWithURL:[NSURL URLWithString:[shopDic objectForKey:@"shopPic"]] ];
    [view addSubview:shopImg];
    //店铺名称
    UILabel *lbl= [[UILabel alloc]initWithFrame:CGRectMake(shopImg.right+10, view.top+10, 250, 20)];
//    lbl.text =@"双十一给力店铺";
    NSString *nameStr = [shopDic objectForKey:@"name"];
    lbl.text = nameStr;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbl];
    //new
    UIImageView *newImg = [[UIImageView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+2, 20*KScreenWidth/320, 13*KScreenWidth/320)];
    newImg.image = [UIImage imageNamed:@"xzzm_MyStreet_newLabelLeft"];
    [view addSubview:newImg];
    // 箭头
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(view.right-30, view.top+10, 8*KScreenWidth/320, 15*KScreenWidth/320)];
    rightImg.image = [UIImage imageNamed:@"xzzbk_home_right"];
    [view addSubview:rightImg];
    //我是分割线
    UIView *fenge = [[UIView alloc]initWithFrame:CGRectMake(5, shopImg.bottom+10, KScreenWidth-30, 1)];
    fenge.backgroundColor = [UIColor grayColor];
    fenge.alpha = 0.5;
    [view addSubview:fenge];
    //店铺图片
    NSDictionary *dic =[imgArr objectAtIndex:0];
    NSDictionary *dic1=[imgArr objectAtIndex:1];
    NSDictionary *dic2 =[imgArr objectAtIndex:2];
    NSDictionary *dic3 =[imgArr objectAtIndex:3];
    UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(view.left+5, fenge.bottom+5, 60*KScreenWidth/320, 60*KScreenWidth/320)];
    [photo sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"picurl"]]];
    [view addSubview:photo];
    
    UIImageView *photo1 = [[UIImageView alloc]initWithFrame:CGRectMake(photo.right+10*KScreenWidth/320, fenge.bottom+5, 60*KScreenWidth/320, 60*KScreenWidth/320)];
//    photo1.image = [dic1 objectForKey:@"picurl"];
    [photo1 sd_setImageWithURL:[NSURL URLWithString:[dic1 objectForKey:@"picurl"]]];
    [view addSubview:photo1];
    
    UIImageView *photo2 = [[UIImageView alloc]initWithFrame:CGRectMake(photo1.right+10*KScreenWidth/320, fenge.bottom+5, 60*KScreenWidth/320, 60*KScreenWidth/320)];
//    photo2.image = [dic2 objectForKey:@"picurl"];
    [photo2 sd_setImageWithURL:[NSURL URLWithString:[dic2 objectForKey:@"picurl"]]];
    [view addSubview:photo2];
    
    UIImageView *photo3 = [[UIImageView alloc]initWithFrame:CGRectMake(photo2.right+10*KScreenWidth/320, fenge.bottom+5, 60*KScreenWidth/320, 60*KScreenWidth/320)];
//    photo3.image = [dic3 objectForKey:@"picurl"];
    [photo3 sd_setImageWithURL:[NSURL URLWithString:[dic3 objectForKey:@"picurl"]]];
    [view addSubview:photo3];
    
    //关注按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(KScreenWidth/2-(100*KScreenWidth/320)/2, photo.bottom+10, 80*KScreenWidth/320, 15*KScreenWidth/320);
    [btn setTitle:@"立即关注" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"xzzm_Shop_selBg"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    [view addSubview:btn];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shopArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (IS_IPHONE_4 && IS_IPHONE_5) {
//        return 190;
//    }
    return 190*KScreenWidth/320;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    UIViewController *viewController = [[CYLDetailsViewController alloc] init];
//    viewController.hidesBottomBarWhenPushed = YES;  // This property needs to be set before pushing viewController to the navigationController's stack.
//
//    [self.navigationController pushViewController:viewController animated:YES];
//}

@end
