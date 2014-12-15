//
//  PinYinForObjc.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "PinYinForObjc.h"
#import "PinYinData.h"

@implementation PinYinForObjc



+ (void)convertToPinYin:(NSArray *)array callback:(void(^)(NSArray *sortedSectionArray, NSArray *sortedIndexArray,  NSArray *sortedDataArray))callback {
    //用来存放头字母索引的数组
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    //给tableview使用的section数组
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    //用来存放section下的元素
    NSMutableArray *sectionItemArray = [[NSMutableArray alloc] init];
    NSString *tempIndex;

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (NSString __strong *string in array) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableArray *pinYinArray = [[self chineseConvertToPinYinArray:string] mutableCopy];
        
        //多音字的姓，需特殊处理
        NSString *sName = [string substringToIndex:1];
        
        if ([sName isEqualToString:@"曾"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:4] isEqualToString:@"zeng"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        } else if ([sName isEqualToString:@"解"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:3] isEqualToString:@"xie"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        } else if ([sName isEqualToString:@"仇"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:3] isEqualToString:@"qiu"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        } else if ([sName isEqualToString:@"查"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:3] isEqualToString:@"zha"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        } else if ([sName isEqualToString:@"乐"] || [sName isEqualToString:@"樂"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:3] isEqualToString:@"yue"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        } else if ([sName isEqualToString:@"单"] || [sName isEqualToString:@"單"]) {
            for (NSString *pinyin in [pinYinArray copy]) {
                if (![[pinyin substringToIndex:4] isEqualToString:@"shan"]) {
                    [pinYinArray removeObject:pinyin];
                }
            }
        }
        
        NSString *index = [pinYinArray[0] substringToIndex:1];
        
        //创建首字母索引
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //判断首字符是否为字母
        if ([predicate evaluateWithObject:index]) {
            //首字母大写
            index = [index capitalizedString];
            if (![indexArray containsObject:index]) {
                [indexArray addObject:index];
            }
        } else {
            index = @"#";
            if (![indexArray containsObject:index]) {
                [indexArray addObject:index];
            }
        }
        
        //创建缩写
        NSMutableArray *headsArray = [[NSMutableArray alloc] init];
        
        for (NSString *string in pinYinArray) {
            NSString *heads = [[NSString alloc] init];
            NSArray *split = [string componentsSeparatedByString:@" "];
            for (NSString *c in split) {
                if (![c isEqualToString:@""]) {
                    heads = [heads stringByAppendingString:[c substringToIndex:1]];
                }
            }
            [headsArray addObject:heads];
        }
        
        PinYinData *data = [[PinYinData alloc] init];
        data.pinYin = pinYinArray;
        data.string = string;
        data.index = index;
        data.heads = headsArray;
        data.sortedString = [pinYinArray[0] lowercaseString];
        [dataArray addObject:data];
    }
    
    //排序后的索引字母
    NSArray *sortedIndexArray = [indexArray sortedArrayUsingSelector:@selector(compare:)];
    
    //按照拼音对dataArray进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sortedString" ascending:YES]];
    [dataArray sortUsingDescriptors:sortDescriptors];
    
    for (PinYinData *data in dataArray) {
        //给section分组
        if (![tempIndex isEqualToString:data.index]) {
            sectionItemArray = [[NSMutableArray alloc] init];
            [sectionItemArray addObject:data.string];
            [sectionArray addObject:sectionItemArray];
            tempIndex = data.index;
        } else {
            [sectionItemArray addObject:data.string];
        }
    }
    
    
    callback([sectionArray copy], [sortedIndexArray copy], [dataArray copy]);
}

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese {
    NSString *sourceText = chinese;
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    
    return outputPinyin;
}

+ (NSArray *)chineseConvertToPinYinArray:(NSString*)chinese {
    NSString *sourceText = chinese;
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSArray *outputPinyinArray = [PinyinHelper toHanyuPinyinStringArrayWithNSString:sourceText withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
    
    return outputPinyinArray;
}

+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese {
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSMutableString *outputPinyin = [[NSMutableString alloc] init];
    for (int i=0;i <chinese.length;i++) {
        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[chinese characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil!=mainPinyinStrOfChar) {
            [outputPinyin appendString:[mainPinyinStrOfChar substringToIndex:1]];
        } else {
            break;
        }
    }
    return outputPinyin;
}

+ (BOOL)isIncludeChinese:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

@end
