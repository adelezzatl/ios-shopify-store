//
//  ProductDetailViewController.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ShopifyApi.h"

#import "Buy.h"

@interface ProductDetailViewController()

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.product.title;
    self.productImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.product.images firstObject].src]]];
    BUYProductVariant * variant = [self.product.variants firstObject];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f $", [variant.price floatValue]];
}

@end
