//
//  BUYProduct+Additions.h
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "Buy.h"

@interface BUYProduct (Additions)

// Returns {'A' : [BUYProduct], 'B' : [BUYProduct]}
+ (NSDictionary *)sortedProductsByTitle:(NSArray *)products;

@end
