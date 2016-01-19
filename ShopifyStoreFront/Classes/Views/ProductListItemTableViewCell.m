//
//  ProductListItemTableViewCell.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "ProductListItemTableViewCell.h"
#import "Buy.h"

@interface ProductListItemTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView * previewImageView;
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * inventoryLabel;

@end

@implementation ProductListItemTableViewCell

- (void)updateWithProduct:(BUYProduct *)product {
    self.titleLabel.text = product.title;
    self.previewImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[product.images firstObject].src]]];
    self.previewImageView.layer.cornerRadius = 6.0f;
    self.previewImageView.clipsToBounds = YES;
}

@end
