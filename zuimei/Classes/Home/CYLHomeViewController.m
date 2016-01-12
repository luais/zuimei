//
//  CYLHomeViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLHomeViewController.h"
#import "MyCollectionViewCell.h"
#import "AppDelegate.h"
#import "HandpickTableViewController.h"
#import "ShopViewController.h"
#import "GoodsTableViewController.h"
static NSString *kCellIdentifier = @"collectionCellID";

@interface CYLHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_ohterArr;
}

@end

@implementation CYLHomeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.tabBarItem setBadgeValue:@"3"];
    _ohterArr =[[NSMutableArray alloc] initWithCapacity:0];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionVIew = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:flow];
    [collectionVIew registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    collectionVIew.backgroundColor = [UIColor whiteColor];
    self.view = collectionVIew;
    collectionVIew.delegate  =self;
    collectionVIew.dataSource = self;
    AppDelegate *app =[UIApplication sharedApplication].delegate;
    MBProgressHUD *hud =[[MBProgressHUD alloc] initWithWindow:app.window];
    [app.window addSubview:hud];
//    hud.delegate =self;/
    hud.dimBackground = YES;
    [hud show:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:HomeURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        NSArray *array =[responseObject objectForKey:@"otherList"];
//        NSLog(@"===%@",responseObject);
        [_ohterArr addObjectsFromArray:array];
        [collectionVIew reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
}
//item数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return _ohterArr.count;
        }
            break;
        default:
        {
            return 20;
        }
            break;

    }
}
//列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 10;
        }
            break;
            
        default:{
            return 10;
        }
            break;
    }
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 10;
        }
            break;
            
        default:{
            return 10;
        }
            break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return UIEdgeInsetsMake(20, 20, 40, 20);
        }
            break;
            
        default:{
            return UIEdgeInsetsMake(20, 20, 40, 20);
        }
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size1= CGSizeMake(KScreenWidth/2-30, 100*KScreenWidth/320);
    switch (indexPath.section) {
        case 0:
        {
            return size1;
        }
            break;
            
        default:{
            return size1;
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            NSDictionary *dic =[_ohterArr objectAtIndex:indexPath.item];
//            NSLog(@"===%@",dic);
            NSString *imgUrl =[dic objectForKey:@"pic"];
            cell.backgroundColor = [UIColor clearColor];
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 8;
            [cell.img sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            cell.textLabel.text =[dic objectForKey:@"title"];
       
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =[_ohterArr objectAtIndex:indexPath.item];
    NSString *subjectid =[dic objectForKey:@"subjectid"];
    if (indexPath.row==0) {
        HandpickTableViewController *view =[[HandpickTableViewController alloc] init];
        view.subID =subjectid;
        view.title = [dic objectForKey:@"title"];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        GoodsTableViewController *view =[[GoodsTableViewController alloc] init];
        view.subID =subjectid;
        view.title = [dic objectForKey:@"title"];
        [self.navigationController pushViewController:view animated:YES];

    }

    
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        return YES;
//    }
//    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
//}

#pragma mark - Methods

//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
//}

#pragma mark - Table view

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
//    
//    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
//}
@end
