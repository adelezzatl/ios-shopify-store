//
//  ProductListItemTableViewCell.h
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUYProduct;

@interface ProductListItemTableViewCell : UITableViewCell

- (void)updateWithProduct:(BUYProduct *)product;

@end
