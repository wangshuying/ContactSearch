//
//  SearchViewController.h
//  Search
//
//  Created by wangshuying on 15/1/5.
//  Copyright (c) 2015年 LYZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinYinForObjc.h"
#import "PinYinData.h"

@protocol SearchViewControllerDelegate <NSObject>

- (NSArray *)getSearchData;
- (void)didSelectData:(id)data;

@end

@interface SearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, weak) id<SearchViewControllerDelegate> delegate;

//@property (nonatomic) UISearchBar *mySearchBar;
@property (nonatomic) UITableView *tableView;
//@property (nonatomic) UISearchDisplayController *mySearchDisplayController;
//@property (nonatomic) NSMutableArray *searchResults;

//- (void)initSearchData:(NSArray *)array;

@end
