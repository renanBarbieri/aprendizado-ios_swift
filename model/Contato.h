//
//  Contato.h
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject

@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *address;
@property (strong) NSString *site;

-(Contato*) initWithName: (NSString*)name Phone:(NSString*)phone Address:(NSString*)address AndSite:(NSString*)site;
@end
