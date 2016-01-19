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
#import "BUYProduct+Additions.h"

@interface ProductListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic) NSArray * products;

@property (nonatomic) NSDictionary * sortedProducts; // A-Z sorting applied
@property (nonatomic) NSArray * sortedKeys; // A-Z sorting applied

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
    [self.tableView.pullToRefreshView startAnimating];
    [self loadProducts];
}

- (void)loadProducts {
    [[ShopifyApi client] getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        self.products = [products copy];
        self.sortedProducts = [BUYProduct sortedProductsByTitle:[products copy]];
        self.sortedKeys = [self.sortedProducts.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sortedProducts.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * products = [self.sortedProducts objectForKey:self.sortedKeys[section]];
    return products.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sortedKeys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
    }
    
    BUYProduct * product = [self.sortedProducts objectForKey:self.sortedKeys[indexPath.section]][indexPath.row];
    cell.textLabel.text = product.title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ProductDetailViewController *controller = segue.destinationViewController;
    BUYProduct * product = [self.sortedProducts objectForKey:self.sortedKeys[indexPath.section]][indexPath.row];
    controller.product = product;
}

@end
