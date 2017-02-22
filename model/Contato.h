//
//  Contato.h
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contato : NSObject

@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *address;
@property (strong) NSString *site;
@property (strong) UIImage *photo;

-(Contato*) initWithName: (NSString*)name Phone:(NSString*)phone Address:(NSString*)address AndSite:(NSString*)site;
-(void) updateValues: (NSString*)name Phone:(NSString*)phone Address:(NSString*)address AndSite:(NSString*)site;
@end
