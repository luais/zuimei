//
//  DetailViewController.m
//  zuimei
//
//  Created by Aries on 15/11/7.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "DetailViewController.h"
#import "GoodsDetailViewController.h"

static NSString *identifier = @"identifierCEll";

@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_ShopGoodsArr;
    MBProgressHUD *HUD;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithRed:213/255.0 green:0/255.0 blue:91/255.0 alpha:1]}];
   
    
    _ShopGoodsArr = [[NSMutableArray alloc]initWithCapacity:0];
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:flow];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];

    collectionView.backgroundColor = [UIColor whiteColor];
    self.view = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    //返回按钮
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
    
    NSString *URL = [NSString stringWithFormat: @"http://yyjd.xinzhuzhang.com/m/rihankong/goods/category/search?cid=%@&isFollow=&page=ld&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429786584.315401&v=1.0.9&ios=8.1&sign=c4183d86ffcdbb35dc95293fcb84b4b6",self.catID];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [HUD hide:YES];
        NSLog(@"--responseobject%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"myShopGoodsList"];
        [_ShopGoodsArr addObjectsFromArray:array];
        [collectionView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"====error%@",error);
    }];
    
}

//返回按钮
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//间距列
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//间距行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 0, 10);
}
// 每个item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size1 = CGSizeMake((KScreenWidth-30)/3, KScreenWidth/3+20);
    return size1;
}

//数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSDictionary *dic = [_ShopGoodsArr objectAtIndex:];
    return _ShopGoodsArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_ShopGoodsArr objectAtIndex:indexPath.row];
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (KScreenWidth-30)/3, KScreenWidth/3+20)];
    img.backgroundColor = [UIColor redColor];
    [img sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]];
    [cell addSubview:img];
    
    UILabel *jiage = [[UILabel alloc]initWithFrame:CGRectMake(img.right-50, img.bottom-20, 40, 15)];
//    jiage.text = @"$100";
    jiage.text = [dic objectForKey:@"price"];
    jiage.textColor = [UIColor whiteColor];
    jiage.backgroundColor = [UIColor orangeColor];
    jiage.textAlignment = NSTextAlignmentCenter;
    jiage.font = [UIFont systemFontOfSize:10];
    jiage.layer.cornerRadius = 7;
    jiage.layer.masksToBounds = YES;
    [img addSubview:jiage];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_ShopGoodsArr objectAtIndex:indexPath.row];
    NSString *photoID = [dic objectForKey:@"id"];
    GoodsDetailViewController *view = [GoodsDetailViewController new];
    view.goodsID = photoID;
    [self.navigationController pushViewController:view animated:YES];
    
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
