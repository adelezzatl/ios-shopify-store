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
#import "ProductListItemTableViewCell.h"
#import "ProductListHeaderTableViewCell.h"

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
    self.title = @"Products";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:46/255 green:53/255 blue:56/255 alpha:1.0f];
    
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
    return self.sortedProducts.allKeys.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    NSArray * products = [self.sortedProducts objectForKey:self.sortedKeys[section - 1]];
    return products.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return self.sortedKeys[section - 1];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 28;
    }
    
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProductListHeaderTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:@"ProductHeader"];
    if (section == 0) {
        [headerView updateWithHeader:@""];
    }
    else {
        [headerView updateWithHeader:self.sortedKeys[section - 1]];
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"AddProductCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddProductCell"];
        }
        
        return cell;
    }
    else {
        ProductListItemTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
        if (!cell) {
            cell = [[ProductListItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
        }
        
        BUYProduct * product = [self.sortedProducts objectForKey:self.sortedKeys[indexPath.section - 1]][indexPath.row];
        [cell updateWithProduct:product];
    
        return cell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ProductDetailViewController *controller = segue.destinationViewController;
    BUYProduct * product = [self.sortedProducts objectForKey:self.sortedKeys[indexPath.section]][indexPath.row];
    controller.product = product;
}

@end
