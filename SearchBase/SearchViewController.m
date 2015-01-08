//
//  SearchViewController.m
//  Search
//
//  Created by wangshuying on 15/1/5.
//  Copyright (c) 2015年 LYZ. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    NSArray *searchData;
    NSArray *indexArray;
    NSArray *sectionArray;
    NSArray *dataArray;
    NSMutableArray *searchResults;
    
    UISearchDisplayController *mySearchDisplayController;
    UISearchBar *mySearchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索"];
    
    
    mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    mySearchDisplayController.active = NO;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = mySearchBar;
    
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initSearchData {
    
    if (!searchData) {
        searchData = [self.delegate getSearchData];
        
        [PinYinForObjc convertToPinYin:searchData callback:^(NSArray *sortedSectionArray, NSArray *sortedIndexArray, NSArray *sortedDataArray){
            indexArray = sortedIndexArray;
            sectionArray = sortedSectionArray;
            dataArray = sortedDataArray;
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        return [[sectionArray objectAtIndex:section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self initSearchData];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return [indexArray count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        NSString *key = [indexArray objectAtIndex:section];
        return key;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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

#pragma mark - 设置右方表格的索引数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return indexArray;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self.delegate didSelectData:((PinYinData *)searchResults[indexPath.row]).string];
    }
    else {
        [self.delegate didSelectData:[[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    }
}

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

@end
