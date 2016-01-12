//
//  ShopViewController.m
//  zuimei
//
//  Created by Aries on 15/11/5.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCollectionViewCell.h"
#import "ShopHeaderCollectionReusableView.h"
#import "ShopFooterCollectionReusableView.h"
static NSString *kCellIdentifier = @"collectionCellID";
static NSString *kHeaderIdentifer =@"HeaderCollectionCellID";
static NSString *kFooterIdentifer =@"FooterCollectionCellID";

@interface ShopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray * _shopArray;
    
}

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shopArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]collectionViewLayout:flow];
    [collection registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    [collection registerClass:[ShopHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifer];
    
    [collection registerClass:[ShopFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterIdentifer];
    
    collection.backgroundColor = [UIColor whiteColor];
    self.view = collection;
    collection.showsVerticalScrollIndicator =NO;
    collection.dataSource = self;
    collection.delegate  =self;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url =[NSString stringWithFormat:@"http://yyjd.xinzhuzhang.com/m/rihankong/subject/detail?id=%@&page=10&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429290291.817267&v=1.0.9&ios=8.1&sign=66b11e8e60830c23ef0e1f6054f7fde1",self.subID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"----%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"shopList"];
        [_shopArray addObjectsFromArray:array];
        [collection reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"___%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size1 = CGSizeMake((KScreenWidth-20)/2, (KScreenWidth-20)/2);
    CGSize size2 = CGSizeMake(KScreenWidth-10, KScreenWidth-10);

    return size1;
}

//数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dataDic = [_shopArray objectAtIndex:section];
    NSArray *itemArray = [dataDic objectForKey:@"itemList"];
    
    return itemArray.count;
    
//    NSDictionary *dataDic = [_shopArray objectAtIndex:section];
//    NSArray *itemArray = [dataDic objectForKey:@"itemList"];
//    NSDictionary *dict = [itemArray objectAtIndex:section];
//    NSArray *goodsArray = [dict objectForKey:@"goodsList"];
//    return goodsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _shopArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

//    NSDictionary *dataDic = [_shopArray objectAtIndex:indexPath.section];
//    NSArray *itemArray = [dataDic objectForKey:@"itemList"];
//    NSDictionary *dict = [itemArray objectAtIndex:indexPath.row];
//    NSArray *goodsArray = [dict objectForKey:@"goodsList"];
//    NSDictionary *dic = [goodsArray objectAtIndex:indexPath.section];
//    
//    [cell.pictureB sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]];
//    cell.price.text = [dic objectForKey:@"discountprice"];
    
    return cell;
}
//间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 5, 20, 5);
}


//区头区委
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        ShopHeaderCollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderIdentifer forIndexPath:indexPath];
        
        NSDictionary *dataDic = [_shopArray objectAtIndex:indexPath.section];
        NSDictionary *shopDic = [dataDic objectForKey:@"shop"];
        NSString *shopPic = [shopDic objectForKey:@"shopPic"];
        [head.photo sd_setImageWithURL:[NSURL URLWithString:shopPic]];
        head.nameLab.text = [shopDic objectForKey:@"name"];
        
        return head;
    }else{
        ShopFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kFooterIdentifer forIndexPath:indexPath];
        return footer;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenWidth, 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(KScreenWidth, 40);
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
