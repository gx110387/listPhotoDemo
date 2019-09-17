//
//  GCJTableViewController.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/4/4.
//  Copyright © 2018年 58. All rights reserved.
//

#import "GCJTableViewController.h"
#import <Masonry.h>


@interface GCJTableViewController ()
@property(nonatomic, strong) YCEmptyDataSetSource *emptyDataSetSource;
@end

@implementation GCJTableViewController

- (instancetype)initWithTableStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initTableView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)_initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:self.style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.emptyDataSetSource = self.emptyDataSetSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSetSource;
    if (isiOS11Above) {
//        _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//        _tableView.estimatedRowHeight = 0;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark --
#pragma mark -- tableViewdelegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (YCEmptyDataSetSource *)emptyDataSetSource {
    if (!_emptyDataSetSource) {
        _emptyDataSetSource = [[YCEmptyDataSetSource alloc] init];
    }
    return _emptyDataSetSource;
}
@end
