//
//  BUYProduct+Additions.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "BUYProduct+Additions.h"

@implementation BUYProduct (Additions)

+ (NSDictionary *)sortedProductsByTitle:(NSArray *)products {
    NSMutableDictionary * sortedProducts = [NSMutableDictionary new];
    
    // Init headers with A-Z,#
    for (NSString * title in [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]) {
        [sortedProducts setObject:[NSMutableArray new] forKey:title];
    }
    
    // Adding products to sorted dictionary
    for (BUYProduct * product in products) {
        NSString * key = [product.title substringWithRange:NSMakeRange(0, 1)];
        key = ([key length] && isnumber([key characterAtIndex:0])) ? @"#" : [key uppercaseString];
        
        NSMutableArray * headerValues = [sortedProducts objectForKey:key];
        [headerValues addObject:product];
    }
    
    // Cleaning entries with no data
    for (NSString * key in [sortedProducts copy]) {
        NSArray * values = [sortedProducts objectForKey:key];
        if (values.count == 0) {
            [sortedProducts removeObjectForKey:key];
        }
    }
    
    return sortedProducts;
}

@end
