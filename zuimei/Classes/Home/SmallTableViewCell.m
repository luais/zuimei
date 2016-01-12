//
//  SmallTableViewCell.m
//  zuimei
//
//  Created by Aries on 15/11/6.
//  Copyright © 2015年 youke. All rights reserved.
//

#import "SmallTableViewCell.h"

@implementation SmallTableViewCell

+ (instancetype)smallCell:(UITableView *)tableView{
        static NSString *CellIdentifier = @"Cell";
    
    
        SmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SmallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//    _pictureB = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,(KScreenWidth-30)/2, (KScreenWidth-30)/2)];
//        _pictureB.image = [UIImage imageNamed:@"yema18"];
//        [self addSubview:_pictureB];
        _pictureB = [UIButton buttonWithType:UIButtonTypeCustom];
        _pictureB.frame = CGRectMake(10, 10,(KScreenWidth-30)/2, (KScreenWidth-30)/2);
        [self addSubview:_pictureB];
        [_pictureB addTarget:self action:@selector(clickb:) forControlEvents:UIControlEventTouchUpInside];
    
        _pictureS =[UIButton buttonWithType:UIButtonTypeCustom];
        _pictureS.frame=CGRectMake(_pictureB.right+10,_pictureB.top,(KScreenWidth-30)/2,(KScreenWidth-30)/2);
        [_pictureS addTarget:self action:@selector(clicks:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pictureS];
    
//        _bigPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, _pictureB.bottom+5, KScreenWidth-20, 200)];
//        _bigPic.image = [UIImage imageNamed:@"yema18"];
//        [self addSubview:_bigPic];
    
    //价格
        _price = [[UILabel alloc]initWithFrame:CGRectMake(_pictureB.right-55, _pictureB.bottom-20, 50, 15)];
        _price.text = @"$100";
        _price.font = [UIFont systemFontOfSize:9];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.backgroundColor = [UIColor orangeColor];
        _price.layer.cornerRadius = 9;
        _price.layer.masksToBounds =  YES;
        [self addSubview:_price];
        
        _price1 = [[UILabel alloc]initWithFrame:CGRectMake(_pictureS.right-55, _pictureS.bottom-20, 50, 15)];
        _price1.text = @"$100";
        _price1.font = [UIFont systemFontOfSize:9];
        _price1.textAlignment = NSTextAlignmentCenter;
        _price1.backgroundColor = [UIColor orangeColor];
        _price1.layer.cornerRadius = 9;
        _price1.layer.masksToBounds =  YES;
        [self addSubview:_price1];
    
        // Configure the cell...
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:229/255.0 green:0 blue:97/255.0 alpha:1].CGColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSDictionary *dic = [self.imgArr objectAtIndex:0];
//    [_pictureB sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic"]]];
    [_pictureB sd_setBackgroundImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic"]] forState:UIControlStateNormal];
    _price.text = [dic objectForKey:@"discountprice"];
    NSDictionary *dic1 = [self.imgArr objectAtIndex:1];
    [_pictureS sd_setBackgroundImageWithURL:[NSURL URLWithString:[dic1 objectForKey:@"pic"]] forState:UIControlStateNormal];
    _price1.text = [dic1 objectForKey:@"discountprice"];
    
    
    
}
-(void)clickbofBlock:(block)newblock{
    self.blockb =newblock;
}
-(void)clicksofBlock:(block)newblock{
    self.blocks =newblock;
}
-(void)clickb:(UIButton*)button{
    self.blockb();
}
-(void)clicks:(UIButton*)button{
    self.blocks();
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
