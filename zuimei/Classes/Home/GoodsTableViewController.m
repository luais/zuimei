//
//  GoodsTableViewController.m
//  zuimei
//
//  Created by Aries on 15/11/6.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "GoodsTableViewController.h"
#import "BigPicTableViewCell.h"
#import "SmallTableViewCell.h"
#import "GoodsDetailViewController.h"
#import "LoginShopViewController.h"

@interface GoodsTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_goodsArray;
    MBProgressHUD *HUD;
    NSArray *_imgArr;
    NSString *_sid;
}
@property(nonatomic,strong)UIImageView *photo; //店铺头像
@property(nonatomic,strong)UILabel *nameLab; //店铺名称
@property(nonatomic,strong)UIButton *buyBtn; //进店查看更多
@end

@implementation GoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithRed:213/255.0 green:0/255.0 blue:91/255.0 alpha:1]}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _goodsArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"xzzm_Commons_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    HUD = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    HUD.dimBackground = YES;
    [HUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [HUD hide: YES];
    NSString *url =[NSString stringWithFormat:@"http://yyjd.xinzhuzhang.com/m/rihankong/subject/detail?id=%@&page=10&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429290291.817267&v=1.0.9&ios=8.1&sign=66b11e8e60830c23ef0e1f6054f7fde1",self.subID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"===%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"shopList"];
        [_goodsArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];


    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _goodsArray.count;
//    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dataDic = [_goodsArray objectAtIndex:section];
    NSArray *itemArray = [dataDic objectForKey:@"itemList"];
    
    return itemArray.count;
//    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *secDic =[_goodsArray objectAtIndex:indexPath.section];
    NSArray *rowArr =[secDic objectForKey:@"itemList"];
    NSDictionary *rowDic =[rowArr objectAtIndex:indexPath.row];
    NSArray *goodsArr = [rowDic objectForKey:@"goodsList"];
    //大图还是小图
    NSString *STR =[NSString stringWithFormat:@"%@",[rowDic objectForKey:@"isBig"]];
    
    if ([STR isEqualToString:@"1"]){
        static NSString *CELLid =@"cellID";
        BigPicTableViewCell *CELL =[tableView dequeueReusableCellWithIdentifier:CELLid];
        if (!CELL) {
            CELL =[[BigPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLid];
        }
        
        CELL.imgArr =goodsArr;
//        CELL.imgArr = _imgArr;
//        BigPicTableViewCell *CELL = [BigPicTableViewCell bigPicCell:tableView];
//        [CELL.bigPic sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"pic"]]];
        
        
        return CELL;
    }else{
        static NSString *CELLid =@"cell1ID";
        SmallTableViewCell *CELL =[tableView dequeueReusableCellWithIdentifier:CELLid];
        if (!CELL) {
            CELL =[[SmallTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLid];
        }
//           SmallTableViewCell *CELL = [SmallTableViewCell smallCell:tableView];
//        [CELL.pictureB sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"pic"]]];
        CELL.imgArr = goodsArr;
//         CELL.imgArr = _imgArr;
        [CELL clickbofBlock:^(void) {
            
            NSDictionary *dic =[goodsArr objectAtIndex:0];
            NSString * pictureID = [dic objectForKey:@"id"];
            GoodsDetailViewController *view1 = [GoodsDetailViewController new];
            view1.goodsID = pictureID;
            [self.navigationController pushViewController:view1 animated:YES];

            
        }];
        [CELL clicksofBlock:^(void) {
            NSDictionary *dic =[goodsArr objectAtIndex:1];
            NSString * pictureID = [dic objectForKey:@"id"];
            GoodsDetailViewController *view1 = [GoodsDetailViewController new];
            view1.goodsID = pictureID;
            [self.navigationController pushViewController:view1 animated:YES];
        }];
        return CELL;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic =[_goodsArray objectAtIndex:indexPath.section];
    NSArray *rowArr =[secDic objectForKey:@"itemList"];
    NSDictionary *rowDic =[rowArr objectAtIndex:indexPath.row];
    NSLog(@"==%@",[rowDic objectForKey:@"isBig"]);
    NSString *STR =[NSString stringWithFormat:@"%@",[rowDic objectForKey:@"isBig"]];
    
    
    if ([STR isEqualToString:@"1"]) {
        return 310;
    }else{
        return (KScreenWidth)/2;
    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *secDic =[_goodsArray objectAtIndex:indexPath.section];
    NSArray *rowArr =[secDic objectForKey:@"itemList"];
    NSDictionary *rowDic =[rowArr objectAtIndex:indexPath.row];
    
    NSArray *goodsArr = [rowDic objectForKey:@"goodsList"];
//    _imgArr = goodsArr;
//    NSDictionary *pictureDic = [goodsArr objectAtIndex:indexPath.row];
    NSString *STR =[NSString stringWithFormat:@"%@",[rowDic objectForKey:@"isBig"]];
    
    
    if ([STR isEqualToString:@"1"]){
        BigPicTableViewCell *view1 = [BigPicTableViewCell new];
        view1.imgArr = goodsArr;
        NSDictionary *pictureDic =[goodsArr objectAtIndex:0];
        NSString * pictureID = [pictureDic objectForKey:@"id"];
        GoodsDetailViewController *view = [GoodsDetailViewController new];
        view.goodsID = pictureID;
        [self.navigationController pushViewController:view animated:YES];
        return;
    }else{
        SmallTableViewCell *view1 = [SmallTableViewCell new];
        view1.imgArr = goodsArr;
        NSDictionary *pictureDic =[goodsArr objectAtIndex:0];
        NSString * pictureID = [pictureDic objectForKey:@"id"];
//        NSDictionary *pictureDic1 =[goodsArr objectAtIndex:1];
//        NSString * pictureID1 = [pictureDic1 objectForKey:@"id"];
        GoodsDetailViewController *view = [GoodsDetailViewController new];
        view.goodsID = pictureID;
//        view.goodsID = pictureID1;
        [self.navigationController pushViewController:view animated:YES];
        return;
    }
    
    
}
///Users/leimo/Desktop/test/zuimei/zuimei/Classes/Home/GoodsTableViewController.m:141:26: Code will never be executed
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *header = @"headerView";
    
    NSDictionary *dic = [_goodsArray objectAtIndex:section];
    NSDictionary *shopDic = [dic objectForKey:@"shop"];
    NSString *sID = [shopDic objectForKey:@"sid"];
    _sid = sID;
    
    
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:header];
    }
//    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *backGround = [UIButton buttonWithType:UIButtonTypeCustom];
    backGround.frame = CGRectMake(5, 10, KScreenWidth-10, 80);
//    backGround.image = [UIImage imageNamed:@"xzzm_Subject_cellTopBg"];
    [backGround setBackgroundImage:[UIImage imageNamed:@"xzzm_Subject_cellTopBg"] forState:UIControlStateNormal];
    backGround.adjustsImageWhenHighlighted = NO;
    [headerView addSubview:backGround];
    [backGround addTarget:self action:@selector(loginShop) forControlEvents:UIControlEventTouchUpInside];
    //店铺图标
    _photo = [[UIImageView alloc]initWithFrame:CGRectMake(40, backGround.top+20, 45, 45)];
//    _photo.image = [UIImage imageNamed:@"yema18"];
    [_photo sd_setImageWithURL:[NSURL URLWithString:[shopDic objectForKey:@"shopPic"]]];
    [headerView addSubview:_photo];
    //NAME
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_photo.right+10, _photo.top, 200, 30)];
    _nameLab.font = [UIFont systemFontOfSize:15];
//    _nameLab.text = @"好人没错 就是我";
    _nameLab.text = [shopDic objectForKey:@"name"];
    [headerView addSubview:_nameLab];
//    self.tableView.tableHeaderView = headerView;
    
    //描述相符
    UILabel *miaoshu = [[UILabel alloc]initWithFrame:CGRectMake(40, _photo.bottom+5, KScreenWidth-80, 15)];
    miaoshu.backgroundColor = [UIColor orangeColor];
//    if (self.subID[intValue]%2==1) {
//        miaoshu.text = @"描述相符:4.8 高于同行";
//    }else{
//        miaoshu.text = @"DJHSioushfio s";
//    }
    miaoshu.text = @"描述相符:4.8 高于同行";
    miaoshu.textColor = [UIColor colorWithRed:229/255.0 green:0 blue:97/255.0 alpha:1];
    miaoshu.font = [UIFont systemFontOfSize:10];
    miaoshu.layer.cornerRadius = 5;
    miaoshu.layer.masksToBounds = YES;
    miaoshu.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:miaoshu];
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *footerID = @"footer";
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footerID];
    }
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.frame = CGRectMake((KScreenWidth/2)-56, 10, 112, 25);
    [_buyBtn setImage:[UIImage imageNamed:@"xzzm_Subject_more"] forState:UIControlStateNormal];
    [footerView addSubview:_buyBtn];
    [_buyBtn addTarget:self action:@selector(loginShop) forControlEvents:UIControlEventTouchUpInside];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

//点击店铺头进入店铺
-(void)loginShop{
    NSLog(@"进入店铺拉");
    LoginShopViewController *view = [LoginShopViewController new];
    view.ShopID = _sid;
    [self.navigationController pushViewController:view animated:YES];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = KScreenHeight;
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 70, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 70, 0, 0);
//        }
//    }
//}


@end
