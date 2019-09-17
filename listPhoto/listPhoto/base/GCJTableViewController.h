//
//  GCJTableViewController.h
//  58GuCheJia
//
//  Created by 吴丹 on 2018/4/4.
//  Copyright © 2018年 58. All rights reserved.
//

#import "GCJBaseViewController.h"

@interface GCJTableViewController : GCJBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) IBInspectable UITableViewStyle style;
- (instancetype)initWithTableStyle:(UITableViewStyle)style;
@end
