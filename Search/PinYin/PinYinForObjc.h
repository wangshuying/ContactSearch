//
//  PinYinForObjc.h
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanyuPinyinOutputFormat.h"
#import "PinyinHelper.h"

@interface PinYinForObjc : NSObject

+ (void)convertToPinYin:(NSArray *)array callback:(void(^)(NSArray *sortedSectionArray, NSArray *sortedIndexArray, NSArray *sortedDataArray))callback;
+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;//转换为拼音
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;//转换为拼音首字母
+ (BOOL)isIncludeChinese:(NSString*)str;

@end
