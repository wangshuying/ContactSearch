//
//
//
//  Created by kimziv on 13-9-14.
//

#include "ChineseToPinyinResource.h"
#include "HanyuPinyinOutputFormat.h"
#include "PinyinFormatter.h"
#include "PinyinHelper.h"

#define HANYU_PINYIN @"Hanyu"
#define WADEGILES_PINYIN @"Wade"
#define MPS2_PINYIN @"MPSII"
#define YALE_PINYIN @"Yale"
#define TONGYONG_PINYIN @"Tongyong"
#define GWOYEU_ROMATZYH @"Gwoyeu"

@implementation PinyinHelper

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [PinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat {
    return [PinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
}

+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat {
    NSMutableArray *pinyinStrArray =[NSMutableArray arrayWithArray:[PinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch]];
    if (nil != pinyinStrArray) {
        for (int i = 0; i < (int) [pinyinStrArray count]; i++) {
            [pinyinStrArray replaceObjectAtIndex:i withObject:[PinyinFormatter formatHanyuPinyinWithNSString:
                                                               [pinyinStrArray objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
        }
        return pinyinStrArray;
    }
    else return nil;
}

+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [[ChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch {
    return [PinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN];
}

+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch {
    return [PinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN];
}

+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch {
    return [PinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN];
}

+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch {
    return [PinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN];
}

+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem {
    NSArray *hanyuPinyinStringArray = [PinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
            
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    return [PinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch];
}

+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    NSArray *hanyuPinyinStringArray = [PinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray =[NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater {
    NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
    for (int i = 0; i <  str.length; i++) {
        NSString *mainPinyinStrOfChar = [PinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil != mainPinyinStrOfChar) {
            [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
            if (i != [str length] - 1) {
                [resultPinyinStrBuf appendString:seperater];
            }
        }
        else {
            [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
        }
    }
    return resultPinyinStrBuf;
}

+ (NSArray *)toHanyuPinyinStringArrayWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < str.length; i++) {
        NSArray *pinYinArray = [PinyinHelper getHanyuPinyinStringArrayWithChar:[str characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil != pinYinArray) {
            
            for (int j = 0; j < pinYinArray.count; j++) {
                
                if (i == 0) {
                    NSMutableString *pinYin = pinYinArray[j];
                    
                    if (i != [str length] - 1) {
                        [pinYin appendString:seperater];
                    }
                    if (![tempArray containsObject:pinYin]) {
                        [tempArray addObject:pinYin];
                    }
                    
                    resultArray = [tempArray copy];
                } else {
                    for (NSString *pinYin in resultArray) {
                        
                        NSString *newPinyin = [pinYin stringByAppendingString:pinYinArray[j]];
                        
                        if (i != [str length] - 1) {
                            newPinyin = [newPinyin stringByAppendingString:seperater];
                        }
                        
                        if ([tempArray containsObject:pinYin]) {
                            [tempArray replaceObjectAtIndex:[tempArray indexOfObject:pinYin] withObject:newPinyin];
                        } else {
                            [tempArray addObject:newPinyin];
                        }
                        
                    }
                    
                }

            }
            
            resultArray = [tempArray copy];
        
        }
        else {
            if (resultArray.count == 0) {
                [tempArray addObject:[NSString stringWithFormat:@"%C", [str characterAtIndex:i]]];
            } else {
                for (NSString *pinYin in resultArray) {
                    NSString *newPinyin = [pinYin stringByAppendingFormat:@"%C", [str characterAtIndex:i]];
                    
                    if ([tempArray containsObject:pinYin]) {
                        [tempArray replaceObjectAtIndex:[tempArray indexOfObject:pinYin] withObject:newPinyin];
                    } else {
                        [tempArray addObject:newPinyin];
                    }
                }
            }
            resultArray = [tempArray copy];
        }
        
    }
    return [resultArray copy];
}

+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [PinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
    if ((nil != pinyinStrArray) && ((int) [pinyinStrArray count] > 0)) {
        return [pinyinStrArray objectAtIndex:0];
    }
    else {
        return nil;
    }
}

+ (NSArray *)getHanyuPinyinStringArrayWithChar:(unichar)ch withHanyuPinyinOutputFormat:(HanyuPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [PinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
    if ((nil != pinyinStrArray) && ((int) [pinyinStrArray count] > 0)) {
        return pinyinStrArray;
    }
    else {
        return nil;
    }
}

- (id)init {
    return [super init];
}

@end
