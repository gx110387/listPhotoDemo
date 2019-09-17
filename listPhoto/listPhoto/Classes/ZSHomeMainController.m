//
//  ViewController.m
//  listPhoto
//
//  Created by     gaoxing on 2019/9/16.
//  Copyright © 2019 gaoxing. All rights reserved.
//

#import "ZSHomeMainController.h"
#import "UCNavBar.h"
#import "ZSHomeDataModel.h"
#import "ZSHomeMainCell.h"
@interface ZSHomeMainController ()<GCJBaseTableCellDelegate>
@property (nonatomic, strong) UCNavBar *navBar;
@property (nonatomic, assign) NSInteger  page;
@property (nonatomic, strong) NSMutableArray  *dataArr;
@end

@implementation ZSHomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(kNavBarBottom);
        make.bottom.offset(-(kiPhoneXBottomUnSafeAreaHeight));
    }];
    [self _initNavBar];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestFooterData)];
      [self.tableView registerNib:[UINib nibWithNibName:@"ZSHomeMainCell" bundle:nil] forCellReuseIdentifier:@"ZSHomeMainCellIden"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GCJBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZSHomeMainCellIden"];
    cell.delegate = self;
    [cell prepareViewWithData:self.dataArr[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZSHomeMainCell computeHeightWithCellData:self.dataArr[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    ZSHomeDataModel *model = self.dataArr[indexPath.row];
//    [[CHRDispatcher sharedDispatcher] invokeForPath:JumppagecommentPageViewPATH params:@{@"headerInfo":model,@"indexPath":indexPath} andCallback:^(NSDictionary *result) {
//        ZSSquareDynamicModel *model = self.dataArr[indexPath.row];
//        [self.dataArr removeObject:model];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        
//    }];
    
}

-(void)tableViewCell:(GCJBaseTableCell *)cell subViewDidSelectAtIndexPath:(NSIndexPath *)indexPath data:(id)data{
    
   
}



-(void)requestHeaderData{
    self.page = 1;
    [self.tableView.mj_footer setHidden:YES];
    [self requestData:[NSString stringWithFormat:@"%ld",self.page]];
}
-(void)requestFooterData{
    self.page ++;
    [self requestData:[NSString stringWithFormat:@"%ld",self.page]];
}


-(void)requestData:(NSString *)perpage{
    NSDictionary *params = [NSDictionary dictionary];
    
        params = @{@"page":perpage};
 
    [[HYHttpTools shareHttpTools] HY_setHttpToJsonArray:@"https://api.unsplash.com/photos/curated" params:params type:GET isJson:YES passValue:^(NSMutableArray *array) {

        if (array) {
            NSMutableArray *tempArr = [NSMutableArray array];
            NSLog(@"start:%@",[NSDate date]);
            for (NSDictionary *dictionary in array) {
                ZSHomeDataModel *model = [[ZSHomeDataModel alloc] initWithDict:dictionary];
               
                [tempArr addObject:model];
            }
            if ([perpage isEqualToString:@"1"]) {
                // 头部刷新
                self.dataArr = tempArr.mutableCopy;
                [self.tableView.mj_header endRefreshing];
                self.page = 1;
                
            }else{
                [self.dataArr addObjectsFromArray:tempArr];
                [self.tableView.mj_footer endRefreshing];
                
            }

            
            if (self.dataArr.count == 0) {
                
                [self.tableView.mj_footer setHidden:YES];
            }else{
                
                [self.tableView.mj_footer setHidden:NO];
            }
            [self.tableView reloadData];
            
        }
        
    } error:^(NSString *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
- (void)_initNavBar{
    self.navBar = [[UCNavBar alloc] init];
    self.navBar.itemTintColor = [UIColor blackColor];
    self.navBar.barTintColor = [UIColor whiteColor];
    self.navBar.showBottomLine = NO;
    [self.view addSubview:self.navBar];
    self.navBar.title = @"照片";
    self.navBar.titleAlpha = 1;
    self.navBar.barAlpha = 1;
}

@end
