//
//  ShopifyApi.m
//  ShopifyStoreFront
//
//  Created by Guillaume Dorion-Racine on 2016-01-17.
//  Copyright © 2016 Guillaume Dorion-Racine. All rights reserved.
//

#import "ShopifyApi.h"
#import "Buy.h"

@implementation ShopifyApi

+ (BUYClient *)client {
    // Fetch products
    BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"guildorion.myshopify.com"
                                                       apiKey:@"a64084614118289868985651830f1b68"
                                                    channelId:@"43534278"];
    return client;
}

@end
