//
//  ProductListItemTableViewCell.h
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListItemTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView * previewImageView;
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * inventoryLabel;

@end
