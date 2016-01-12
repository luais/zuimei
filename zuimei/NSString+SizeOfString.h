//
//  NSString+SizeOfString.h
//  WeiBoDemoEasy
//
//  Created by HB on 15/3/26.
//  Copyright (c) 2015年 Sh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SizeOfString)

- (CGSize)stringOfSize:(NSDictionary *)dict;
- (CGRect)stringOfRect:(CGSize)size with:(NSDictionary *)attribute;

@end
