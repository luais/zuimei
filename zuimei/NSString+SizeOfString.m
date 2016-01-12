//
//  NSString+SizeOfString.m
//  WeiBoDemoEasy
//
//  Created by HB on 15/3/26.
//  Copyright (c) 2015年 Sh. All rights reserved.
//

#import "NSString+SizeOfString.h"

@implementation NSString (SizeOfString)
- (CGSize)stringOfSize:(NSDictionary *)dict {
    
    CGSize strSize = [self sizeWithAttributes:dict];
    return strSize;
}

- (CGRect)stringOfRect:(CGSize)size with:(NSDictionary *)attribute {
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:self attributes:attribute];
    CGRect rect = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect;
}
@end
