//
//  POISearchDemoViewController.h
//  百度检索功能
//
//  Created by lushuishasha on 16/2/23.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface POISearchDemoViewController : UIViewController<BMKRouteSearchDelegate,BMKSuggestionSearchDelegate,BMKPoiSearchDelegate> {
     //BMKSuggestionSearch *_search;
    
     BMKPoiSearch * _poisearch;
    
    IBOutlet UITextField *_keyText;
    
    IBOutlet UIButton *_nextPageButton;
    
    UITableView *_tableView;
    
    
    int curPage;
}


- (IBAction)startSearch:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *nextPage;

@end
