//
//  ViewController.m
//  Search
//
//  Created by LYZ on 14-1-24.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "ViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "PushView.h"
#import "PinYinData.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *indexArray;
    NSArray *sectionArray;
    NSArray *dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SearchDemo";
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
	self.tableView.tableHeaderView = mySearchBar;
    
    array = [@[@"仇长乐",@"解某某",@"单田芳",@"曾东东",@"查西西",@"乐乘", @"王   書       颖",@"百度baidu",@"谷歌 google",@"jacky  chen  ",@"六六",@"243",@"148",@"9",@"guge",@"苹果",@"苹果iOS",@"谷歌Android",@"微软",@"微软WP",@"table",@"tableview",@"%^&",@"#$%",@"小明",@"孙昭堃",@"赵升海",
               @"张晓光",@"窦锦坤",@"杜欣默",@"张静",@"李凯",@"魏胜",@"姚东升",@"朱燕梅",@"秦玉春",@"武志国",@"别长江",@"冯勇",@"李旭",@"任兆龙",@"洪皓",@"李宏博",@"鞠进步",@"高向平",@"贾小虎",@"劳庆宇",@"赵伟",@"王艳艳",@"刘雨",@"林谡",@"牛海涛",@"马明珠",@"孙宇涛",@"魏军保",@"吴洪波",@"薛亚斌",@"易波",@"赵彩云",@"赵玉珠",@"邹骁",@"陈和珍",@"姚丽媛",@"张淑红",@"小明X",@"孙昭堃A",@"赵升海VV",
               @"张晓光SD",@"窦锦坤GG",@"杜欣默T",@"张静BG",@"李凯ER",@"魏胜FGB",@"姚东升VB",@"朱燕梅B",@"秦玉E",@"武志国EE",@"别长江RT",@"冯勇DF",@"李旭CV",@"任兆龙BB",@"洪皓VB",@"李宏博ET",@"鞠进步GFB",@"高向平C",@"贾小虎V",@"劳庆宇BGB",@"赵伟B",@"王艳艳VB",@"刘雨ERT",@"林谡ERT",@"牛海涛DFGDFG",@"马明珠DFG",@"孙宇涛XC",@"魏军保XCV",@"吴洪波XCV",@"薛亚斌VV",@"易波XC",@"赵彩云BB",@"赵玉珠WER",@"邹骁FF",@"陈和珍GFG",@"姚丽媛E",@"张淑红HH",@"孙昭堃11",@"赵升海22",
               @"张晓光3",@"窦锦坤4",@"杜欣默5",@"张静D",@"李凯5",@"魏胜6",@"姚东升6",@"朱燕梅6",@"秦玉春66",@"武志国6",@"别长江6",@"冯勇6",@"李旭6",@"任兆龙6",@"洪皓6",@"李宏博6",@"鞠进步6",@"高向平6",@"贾小虎6",@"劳庆宇6",@"赵伟6",@"王艳艳6",@"刘雨1",@"林谡1",@"牛海涛1",@"马明珠1",@"孙宇涛1",@"魏军保1",@"吴洪波1",@"薛亚斌1",@"易波1",@"赵彩云1",@"赵玉珠1",@"邹骁1",@"陈和珍1",@"姚丽媛1",@"张淑红1",@"LeBron James",@"Dwyane Wade",@"Chris Bosh",@"Ray Allen",@"Kobe Bryant",@"Pau Gasol",@"Steve Nash",@"Carmelo Anthony",@"Chris Paul",@"Jeremy Lin",@"James Harden",@"Dwight Howard",@"Kevin Durant",@"Russell Westbrook",@"Serge Ibaka",@"Derek Fisher",@"Rajon Rondo",@"Derrick Rose",@"Joakim Noah",@"Balke Griffin",@"Tim Duncan",@"Tony Parker",@"Manu Ginobili",@"Kawhi Leonard",@"Dirk Nowitzki",@"Vince Carter",@"Stephen Curry",@"Klay Thompson",@"Andre Iguodala",@"Kyrie Irving",@"Kevin Love",@"Ricky Rubio",@"Anthony Davis",@"陈祥",@"成文华",@"何艾鑫",@"郭军英",@"李丽",@"刘峰",@"刘九星"] mutableCopy];
    
    [PinYinForObjc convertToPinYin:array callback:^(NSArray *sortedSectionArray, NSArray *sortedIndexArray, NSArray *sortedDataArray){
        indexArray = sortedIndexArray;
        sectionArray = sortedSectionArray;
        dataArray = sortedDataArray;
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        NSString *key = [indexArray objectAtIndex:section];
        return key;
    }
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lab.backgroundColor = [UIColor grayColor];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        lab.text = [NSString stringWithFormat:@"   search result"];
    } else {
        lab.text = [NSString stringWithFormat:@"   %@", [indexArray objectAtIndex:section]];
    }
    
    lab.textColor = [UIColor whiteColor];
    return lab;
}
//#pragma mark - row height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65.0;
//}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return indexArray;
    }
//    return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L", nil];
}

//#pragma mark -
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    NSLog(@"title===%@",title);
//    return index;
//}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return [indexArray count];
    }
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        //return dataArray.count;
        return [[sectionArray objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = ((PinYinData *)searchResults[indexPath.row]).string;
    }
    else {
        //cell.textLabel.text = dataArray[indexPath.row];
        cell.textLabel.text = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    return cell;
    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    
//    cell.textLabel.text = [[sectionArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PushView *pv = [[PushView alloc]initWithNibName:@"PushView" bundle:nil];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        pv.nStr = ((PinYinData *)searchResults[indexPath.row]).string;
    }
    else {
        //pv.nStr = dataArray[indexPath.row];
        pv.nStr = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:pv animated:YES];
}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    double then = CFAbsoluteTimeGetCurrent();
    
    searchResults = [[NSMutableArray alloc]init];
    
    NSString *text = [mySearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text.length>0&&![PinYinForObjc isIncludeChinese:text]) {
        
        bool flag = false;
        
        for (PinYinData *tempData in dataArray) {
            
            //搜索字符串
            NSRange titleResult=[tempData.string rangeOfString:text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                if (![searchResults containsObject:tempData]) {
                    [searchResults addObject:tempData];
                }
                continue;
            }
            
            //搜索拼音
            for (NSString __strong *pinyin in tempData.pinYin) {
                pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
                titleResult=[pinyin rangeOfString:text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    if (![searchResults containsObject:tempData]) {
                        [searchResults addObject:tempData];
                    }
                    flag = true;
                    break;
                }
            }
            
            if (flag) {
                continue;
            }
            
            //搜索缩写
            for (NSString *heads in tempData.heads) {
                titleResult=[heads rangeOfString:text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    if (![searchResults containsObject:tempData]) {
                        [searchResults addObject:tempData];
                    }
                    flag = true;
                    continue;
                }
            }
            
        }
    } else if (mySearchBar.text.length>0&&[PinYinForObjc isIncludeChinese:mySearchBar.text]) {
        for (PinYinData *tempData in dataArray) {
            NSRange titleResult=[tempData.string rangeOfString:text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                if (![searchResults containsObject:tempData]) {
                    [searchResults addObject:tempData];
                }
                continue;
            }
        }
    }
    
    double now = CFAbsoluteTimeGetCurrent();
    NSLog(@"search time: %f sec.", now-then);
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    [UIView animateWithDuration:0.7 animations:^{
//        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    } completion:^(BOOL finished) {
//        ;
//    }];
//}
@end
