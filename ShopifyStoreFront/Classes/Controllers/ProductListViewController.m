//
//  ProductListViewController.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "ProductListViewController.h"
#import "Buy.h"
#import "ProductDetailViewController.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import <libextobjc/extobjc.h>
#import "ShopifyApi.h"

@interface ProductListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic) NSArray * products;

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    @weakify(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self);
        [self loadProducts];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadProducts];
}


- (void)loadProducts {
    [[ShopifyApi client] getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        self.products = [products copy];
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
    }
    
    BUYProduct * product = self.products[indexPath.item];
    cell.textLabel.text = product.title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ProductDetailViewController *controller = segue.destinationViewController;
    controller.product = [self.products objectAtIndex:indexPath.row];
}

@end
