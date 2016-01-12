//
//  ClassViewController.m
//  zuimei
//
//  Created by Aries on 15/11/4.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "ClassViewController.h"
#import "MyClassCollectionViewCell.h"
#import "MyHeaderCollectionReusableView.h"
#import "DetailViewController.h"

static NSString *kCellIdentifer =@"collectionCellID";
static NSString *kHeaderIdentifer =@"HeaderCollectionCellID";
@interface ClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

NSMutableArray *_catItemArray;
    MBProgressHUD *HUD;
}
@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _catItemArray = [[NSMutableArray alloc]initWithCapacity:0];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:flow];
    
    [collectionView registerClass:[MyClassCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifer];
    
    [collectionView registerClass:[MyHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifer];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.view = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    HUD =[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    //    HUD.delegate =self;
    HUD.dimBackground = YES;
    [HUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:FENLEIURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hide:YES];
//        NSLog(@"responseObject: %@",responseObject);
        NSArray *array  = [responseObject objectForKey:@"catItemList"];
        [_catItemArray addObjectsFromArray:array];
        [collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    //标签

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dataDic = [_catItemArray objectAtIndex:section];
    NSArray *catArray = [dataDic objectForKey:@"catlist"];
    return catArray.count;
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
    return UIEdgeInsetsMake(40, 10, 20, 10);
}
// 每个item尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size1 = CGSizeMake((KScreenWidth-40)/3, 100);
    return size1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _catItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifer forIndexPath:indexPath];
    NSDictionary *dataDic = [_catItemArray objectAtIndex:indexPath.section];
    NSArray *catArray = [dataDic objectForKey:@"catlist"];
    NSDictionary *dict = [catArray objectAtIndex:indexPath.row];
    NSString *picUrl = [dict objectForKey:@"picUrl"];
    
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    cell.catName.text = [dict objectForKey:@"catname"];
    cell.backgroundColor= [UIColor clearColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic = [_catItemArray objectAtIndex:indexPath.section];
    NSArray *catArray = [dataDic objectForKey:@"catlist"];
    NSDictionary *dict = [catArray objectAtIndex:indexPath.row];
    NSString *catID = [dict objectForKey:@"catid"];
    
    DetailViewController *detail = [DetailViewController new];
    detail.catID = catID;
    detail.title = [dict objectForKey:@"catname"];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}
//区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MyHeaderCollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderIdentifer forIndexPath:indexPath];
    NSDictionary *dataDic = [_catItemArray objectAtIndex:indexPath.section];
    NSString *nameStr = [dataDic objectForKey:@"catname"];
    head.textLabel.text =nameStr;
    
    
    return head;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(10, 5);
}

@end
