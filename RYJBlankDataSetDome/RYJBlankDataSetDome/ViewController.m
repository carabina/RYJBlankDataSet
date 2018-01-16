//
//  ViewController.m
//  RYJBlankDataSetDome
//
//  Created by devRen on 2018/1/16.
//  Copyright © 2018年 YiJie Ren. All rights reserved.
//

#import "ViewController.h"
#import "RYJBlankDataSet.h"

#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    self.tableView.ryj_blankView = [[RYJBlankView alloc] initWithFrame:CGRectMake(kScreen_Width/2-50, kScreen_Height/2-50, 100, 100)];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"666";
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.ryj_autoAddBlankView = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
