//
//  SYViewController.m
//  SYWebViewBridge
//
//  Created by wsy on 09/05/2020.
//  Copyright (c) 2020 wsy. All rights reserved.
//

#import "SYViewController.h"
#import <SYHybridWebViewController.h>

@interface SYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SYWebViewBridge";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    _datas = @[
        @{@"title": @"SYHybridWebViewController", @"sel": @"toHrbridViewControll"}
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = _datas[indexPath.row][@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selName = _datas[indexPath.row][@"sel"];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(selName)];
    #pragma clang diagnostic pop
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)toHrbridViewControll {
    SYHybridWebViewController *viewController = [[SYHybridWebViewController alloc] init];
    [viewController loadUrl:@"http://localhost:9000/home.html"];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
