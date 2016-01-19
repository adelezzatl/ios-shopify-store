//
//  ProductListHeaderTableViewCell.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-18.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "ProductListHeaderTableViewCell.h"

@interface ProductListHeaderTableViewCell()

@property (nonatomic) IBOutlet UILabel * headerLabel;

@end

@implementation ProductListHeaderTableViewCell

- (void)updateWithHeader:(NSString *)header {
    self.headerLabel.text = header;
}

@end
