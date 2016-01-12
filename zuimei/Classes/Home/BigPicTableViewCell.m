//
//  BigPicTableViewCell.m
//  zuimei
//
//  Created by Aries on 15/11/6.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "BigPicTableViewCell.h"

@implementation BigPicTableViewCell

+ (instancetype)bigPicCell:(UITableView *)tableView{
       static NSString *CellIdentifier1 = @"Cell1";
    
    BigPicTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    //
    if (!cell1) {
        cell1 = [[BigPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell1;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bigPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth-20, KScreenWidth-20)];
        _bigPic.image = [UIImage imageNamed:@"yema18"];
//        _bigPic.backgroundColor = [UIColor redColor];
        [self addSubview:_bigPic];
        
        //价格
        _price = [[UILabel alloc]initWithFrame:CGRectMake(_bigPic.right-55, _bigPic.bottom-20, 50, 15)];
        _price.text = @"$100";
        _price.font = [UIFont systemFontOfSize:9];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.backgroundColor = [UIColor orangeColor];
        _price.layer.cornerRadius = 9;
        _price.layer.masksToBounds =  YES;
        [self addSubview:_price];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSDictionary *dic =[self.imgArr objectAtIndex:0];
    [_bigPic sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]];
    _price.text = [dic objectForKey:@"discountprice"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
