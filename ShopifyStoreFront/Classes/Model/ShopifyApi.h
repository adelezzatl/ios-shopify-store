//
//  ShopifyApi.h
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUYClient;

@interface ShopifyApi : NSObject

+ (BUYClient *)client;

@end
