//
//  TableViewController.m
//  Search
//
//  Created by wangshuying on 15/1/6.
//  Copyright (c) 2015年 LYZ. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SearcheDemo";
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getSearchData {
    NSArray *array = @[@"仇长乐",@"解某某",@"单田芳",@"曾东东",@"查西西",@"乐乘", @"王   書       颖",@"百度baidu",@"谷歌 google",@"jacky  chen  ",@"六六",@"243",@"148",@"9",@"guge",@"苹果",@"苹果iOS",@"谷歌Android",@"微软",@"微软WP",@"table",@"tableview",@"%^&",@"#$%",@"小明",@"孙昭堃",@"赵升海",
                       @"张晓光",@"窦锦坤",@"杜欣默",@"张静",@"李凯",@"魏胜",@"姚东升",@"朱燕梅",@"秦玉春",@"武志国",@"别长江",@"冯勇",@"李旭",@"任兆龙",@"洪皓",@"李宏博",@"鞠进步",@"高向平",@"贾小虎",@"劳庆宇",@"赵伟",@"王艳艳",@"刘雨",@"林谡",@"牛海涛",@"马明珠",@"孙宇涛",@"魏军保",@"吴洪波",@"薛亚斌",@"易波",@"赵彩云",@"赵玉珠",@"邹骁",@"陈和珍",@"姚丽媛",@"张淑红",@"小明X",@"孙昭堃A",@"赵升海VV",
                       @"张晓光SD",@"窦锦坤GG",@"杜欣默T",@"张静BG",@"李凯ER",@"魏胜FGB",@"姚东升VB",@"朱燕梅B",@"秦玉E",@"武志国EE",@"别长江RT",@"冯勇DF",@"李旭CV",@"任兆龙BB",@"洪皓VB",@"李宏博ET",@"鞠进步GFB",@"高向平C",@"贾小虎V",@"劳庆宇BGB",@"赵伟B",@"王艳艳VB",@"刘雨ERT",@"林谡ERT",@"牛海涛DFGDFG",@"马明珠DFG",@"孙宇涛XC",@"魏军保XCV",@"吴洪波XCV",@"薛亚斌VV",@"易波XC",@"赵彩云BB",@"赵玉珠WER",@"邹骁FF",@"陈和珍GFG",@"姚丽媛E",@"张淑红HH",@"孙昭堃11",@"赵升海22",
                       @"张晓光3",@"窦锦坤4",@"杜欣默5",@"张静D",@"李凯5",@"魏胜6",@"姚东升6",@"朱燕梅6",@"秦玉春66",@"武志国6",@"别长江6",@"冯勇6",@"李旭6",@"任兆龙6",@"洪皓6",@"李宏博6",@"鞠进步6",@"高向平6",@"贾小虎6",@"劳庆宇6",@"赵伟6",@"王艳艳6",@"刘雨1",@"林谡1",@"牛海涛1",@"马明珠1",@"孙宇涛1",@"魏军保1",@"吴洪波1",@"薛亚斌1",@"易波1",@"赵彩云1",@"赵玉珠1",@"邹骁1",@"陈和珍1",@"姚丽媛1",@"张淑红1",@"LeBron James",@"Dwyane Wade",@"Chris Bosh",@"Ray Allen",@"Kobe Bryant",@"Pau Gasol",@"Steve Nash",@"Carmelo Anthony",@"Chris Paul",@"Jeremy Lin",@"James Harden",@"Dwight Howard",@"Kevin Durant",@"Russell Westbrook",@"Serge Ibaka",@"Derek Fisher",@"Rajon Rondo",@"Derrick Rose",@"Joakim Noah",@"Balke Griffin",@"Tim Duncan",@"Tony Parker",@"Manu Ginobili",@"Kawhi Leonard",@"Dirk Nowitzki",@"Vince Carter",@"Stephen Curry",@"Klay Thompson",@"Andre Iguodala",@"Kyrie Irving",@"Kevin Love",@"Ricky Rubio",@"Anthony Davis",@"陈祥",@"成文华",@"何艾鑫",@"郭军英",@"李丽",@"刘峰",@"刘九星"];
    return array;
}

- (void)didSelectData:(id)data {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected" message:data delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:nil, nil];
    [alert show];
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
