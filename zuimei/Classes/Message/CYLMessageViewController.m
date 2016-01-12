//
//  CYLMessageViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLMessageViewController.h"
#import "CYLTabBarController.h"

@interface CYLMessageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_classTableView;
    NSMutableArray *_catItemArray;
}

@end

@implementation CYLMessageViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
//    self.title = @"消息";
    [super viewDidLoad];
    _catItemArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:FENLEIURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject: %@",responseObject);
        NSArray *array  = [responseObject objectForKey:@"catItemList"];
        [_catItemArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];

}


#pragma mark - Methods

//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
//}

#pragma mark - Table view
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    [self configureCell:cell forIndexPath:indexPath];
    NSDictionary *dataDic = [_catItemArray objectAtIndex:indexPath.row];
    //获取标签
    NSArray *catArray = [dataDic objectForKey:@"catlist"];
    //图片
    for (NSInteger i=0; i<catArray.count; i++) {
        
    }
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, KScreenWidth-20, 440*KScreenWidth/320)];
    view.image = [UIImage imageNamed:@"xzzm_SubjectList_imageBg"];
    view.userInteractionEnabled = YES;
    [cell addSubview:view];
    //标签
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, view.top, 10*KScreenWidth/320, 15*KScreenWidth/320)];
    img.image = [UIImage imageNamed:@"xzzm_ShopCategory_catTitleBgLeft"];
    [view addSubview:img];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(img.right, view.top, 30*KScreenWidth/320, 15*KScreenWidth/320)];
    NSString *labelStr = [dataDic objectForKey:@"catname"];
    lbl.text = labelStr;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:11];
    lbl.backgroundColor = [UIColor colorWithRed:229/255.0 green:0/255.0 blue:97/255.0 alpha:1.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(lbl.right, view.top, 10*KScreenWidth/320, 15*KScreenWidth/320)];
    img1.image = [UIImage imageNamed:@"xzzm_ShopCategory_catTitleBgRight"];
    [view addSubview:img1];
    
    //衣服
    UIImageView *bigPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, lbl.bottom+10, 135, 100)];
    bigPic.image = [UIImage imageNamed:@"yema18"];
    [view addSubview:bigPic];
    
    UILabel *lblClothes = [[UILabel alloc]initWithFrame:CGRectMake(10, bigPic.bottom+3, bigPic.width, 10)];
    lblClothes.text = @"夏季伤心";
    lblClothes.textAlignment = NSTextAlignmentCenter;
    lblClothes.textColor = [UIColor grayColor];
    lblClothes.font = [UIFont systemFontOfSize:11];
    [view addSubview:lblClothes];
    
    UIImageView *bigPic1 = [[UIImageView alloc]initWithFrame:CGRectMake(bigPic.right+10, lbl.bottom+10, 135, 100)];
    bigPic1.image = [UIImage imageNamed:@"yema18"];
    [view addSubview:bigPic1];
    
    UILabel *lblClothes1 = [[UILabel alloc]initWithFrame:CGRectMake(bigPic.right+10, bigPic.bottom+3, bigPic.width, 10)];
    lblClothes1.text = @"夏季伤心";
    lblClothes1.textAlignment = NSTextAlignmentCenter;
    lblClothes1.textColor = [UIColor grayColor];
    lblClothes1.font = [UIFont systemFontOfSize:11];
    [view addSubview:lblClothes1];
    
    //
     CGFloat leftGap,topGap,width,rightGap,heightOfScrollView,bottomGap;
    leftGap =10*KScreenWidth/320;
    topGap  =(lblClothes1.bottom+10)*KScreenWidth/320;
    width =85*KScreenWidth/320;
    rightGap=(KScreenWidth-leftGap*2-width*3)/3;
    heightOfScrollView = KScreenHeight-NavigationBarHeight-StatusBarHeight-49-14*KScreenWidth/320;
    bottomGap =(heightOfScrollView-15*KScreenWidth/320-topGap-width*3)/3;
    

    for (NSInteger j =0; j<9; j++) {
//        NSDictionary *appDic =[appArr objectAtIndex:j];
        //图标
        UIButton *AppBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        AppBtn.frame =CGRectMake(leftGap+(width+rightGap)*(j%3), topGap+(width+bottomGap)*(j/3), width, 70);
        //            区分点击的是哪一个图标
        AppBtn.tag =j+10;

        [AppBtn setImage:[UIImage imageNamed:@"yema18"] forState:UIControlStateNormal];
        [view addSubview:AppBtn];
        //标题
        UILabel *appLabel =[[UILabel alloc] initWithFrame:CGRectMake(leftGap+(width+rightGap)*(j%3), topGap+70+5*KScreenWidth/320+(width+bottomGap)*(j/3), width, 10*KScreenWidth/320)];
        appLabel.textAlignment =NSTextAlignmentCenter;
        appLabel.font =[UIFont systemFontOfSize:10.0f];
        appLabel.text =@"title";
        appLabel.textColor =[UIColor grayColor];
        appLabel.adjustsFontSizeToFitWidth =YES;
        [view addSubview:appLabel];
        
    }

    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _catItemArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dataDic = [_catItemArray objectAtIndex:section];
    //获取标签
    NSArray *catArray = [dataDic objectForKey:@"catlist"];
    return catArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 460*KScreenWidth/320;
}


@end
