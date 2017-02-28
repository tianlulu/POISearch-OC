//
//  POISearchDemoViewController.m
//  百度检索功能
//
//  Created by lushuishasha on 16/2/23.
//  Copyright © 2016年 lushuishasha. All rights reserved.
//

#import "POISearchDemoViewController.h"

@interface POISearchDemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *addressList;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *name;
@end

@implementation POISearchDemoViewController

- (NSArray *)addressList {
    if (!_addressList) {
        _addressList = [NSArray new];
    }
    return _addressList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_tableView];

    [_keyText addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
}




//两个textField
- (void) textChanged:(UITextField*)sender{
   
    //定位到城市
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city = @"深圳市";
    citySearchOption.keyword = _keyText.text;
    if (![_keyText isEqual:@""] && _keyText.text.length > 1) {
        NSLog(@"哈哈哈");
        BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
        
        if(flag)
        {
            _nextPageButton.enabled = true;
            NSLog(@"城市内检索发送成功");
        }
        else
        {
            _nextPageButton.enabled = false;
            NSLog(@"城市内检索发送失败");
        }
    }else {
        self.addressList = nil;
        [_tableView reloadData];
        
    }
}


//开始查询
- (IBAction)startSearch:(id)sender {
   /*
    //定位到城市
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    //BMKNearbySearchOption *citySearchOption = [[BMKNearbySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city = @"深圳市";
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    if(flag)
    {
        _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
        
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
        _tableView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_tableView];
        
    }
    else
    {
        _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
    
    */
   
   /*
    _search = [[BMKSuggestionSearch alloc]init];
    _search.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = @"深圳市";
    option.keyword  = _keyText.text;
    
    BOOL flag = [_search suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
    */
    
}


/*
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"有结果，结果还需要显示:%@",result);
        
    }else {
        NSLog(@"未找到结果");
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    _search.delegate = nil;
}
*/



#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
       if (error == BMK_SEARCH_NO_ERROR) {
           self.addressList = result.poiInfoList;
           
//           for (int i = 0; i<self.addressList.count ; i++) {
//               BMKPoiInfo *info = self.addressList[i];
//               self.name = info.address;
//               self.city = info.city;
//               NSLog(@"result:name:%@ city:%@",self.name,self.city);
//           }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
    [_tableView reloadData];
}






#pragma mark implement tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    BMKPoiInfo *info = [self.addressList objectAtIndex:indexPath.row];
    cell.textLabel.text = info.city;
    cell.detailTextLabel.text = info.address;
    return cell;
}

@end
