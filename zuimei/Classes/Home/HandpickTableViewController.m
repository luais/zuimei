//
//  HandpickTableViewController.m
//  zuimei
//
//  Created by Aries on 15/11/4.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "HandpickTableViewController.h"

@interface HandpickTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
//    CALayer *layer;
    NSMutableArray *_subjectArray;
}

@end

@implementation HandpickTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithRed:213/255.0 green:0/255.0 blue:91/255.0 alpha:1]}];
    _subjectArray = [[NSMutableArray alloc]initWithCapacity:0];
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"xzzm_Commons_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url =[NSString stringWithFormat:@"http://yyjd.xinzhuzhang.com/m/rihankong/subject/detail?id=%@&page=0&appid=891563670&channel=AppleStore&token=&udid=96bb2fcb54544faa6c9e2a2b3fe36408fc4a0140&idfa=455EE302-DAB0-480E-9718-C2443E900132&idfv=36BC0D61-662E-4CB8-B1E1-898DACAA80AE&mac=02:00:00:00:00:00&timestamp=1429290291.817267&v=1.0.9&ios=8.1&sign=66b11e8e60830c23ef0e1f6054f7fde1&page=10%E5%B0%8F%E7%BC%96%E7%B2%BE%E9%80%89",self.subID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"===%@",responseObject);
        NSArray *array = [responseObject objectForKey:@"subjectList"];
        [_subjectArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
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
#warning Incomplete implementation, return the number of sections
    return _subjectArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //tupian
    NSDictionary *Dic = [_subjectArray objectAtIndex:indexPath.section];
    NSString *imgUrl = [Dic objectForKey:@"pic"];
    NSString *textUrl = [Dic objectForKey:@"title"];
    NSString *timeUrl = [Dic objectForKey:@"subDate"];
    
    //cell
    UIImageView *imgCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth-20, 180) ];
//    imgCell.image =[UIImage imageNamed:@"yema18"];
    [imgCell sd_setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"yema18"]];
    
    imgCell.layer.borderWidth =1;
    imgCell.layer.borderColor =[UIColor colorWithRed:229/255.0 green:0 blue:97/255.0 alpha:1].CGColor;
    imgCell.layer.cornerRadius =10;
    imgCell.layer.masksToBounds =YES;
    [cell addSubview:imgCell];
    //白色边框
    UIImageView *imgLab = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xzzm_SubjectList_labelBg"]];
    imgLab.frame = CGRectMake(0, 150, imgCell.width, 30);
    [imgCell addSubview:imgLab];
    //主题标签
    UIImageView *imgTitle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xzzm_SubjectList_subjectIcon"]];
    imgTitle.frame = CGRectMake(8, 8, 30, 15);
    [imgLab addSubview:imgTitle];
    //文本标题
    CGSize textSize =[textUrl stringOfSize:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(imgTitle.right+8, 8, textSize.width, textSize.height)];
//    textLab.text = @"风衣来袭";
    textLab.text = textUrl;
    textLab.textColor = [UIColor blackColor];
//    textLab.backgroundColor = [UIColor redColor];
//    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:textLab.text];
//    [attribute addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(5, textLab.text.length-2)];
//    [textLab setAttributedText:attribute];
    textLab.font = [UIFont systemFontOfSize:12];
    textLab.textAlignment = NSTextAlignmentLeft;
    [imgLab addSubview:textLab];
    
    UILabel *timeLab = [[ UILabel alloc]initWithFrame:CGRectMake(textLab.right+2, textLab.top, 100, textSize.height)];
    timeLab.textColor = [UIColor colorWithRed:213/255.0 green:0/255.0 blue:91/255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.text = [NSString stringWithFormat:@"(%@)",timeUrl];
    [imgLab addSubview:timeLab];
////     Configure the cell...
//    UIImageView *picture = [[UIImageView alloc]initWithFrame:CGRectMake(imgCell.left, imgCell.top, imgCell.width-2, imgCell.height-2)];
//    picture.image = [UIImage imageNamed:@"yema18"];
//    [imgCell addSubview:picture];
    
    
    return cell;
}


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

@end
