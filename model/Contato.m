//
//  Contato.m
//  swiftTranning
//
//  Created by Renan Hozumi Barbieri on 16/02/17.
//  Copyright © 2017 Universidade Radix. All rights reserved.
//

#import "Contato.h"

@implementation Contato

- (Contato*) initWithName: (NSString*)name Phone:(NSString*)phone Address:(NSString*)address AndSite:(NSString*)site{
    if(self = [super init]){
        self.name = name;
        self.phone = phone;
        self.address = address;
        self.site = site;
        
        return self;
    }
    return nil;
}

-(void) updateValues:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address AndSite:(NSString *)site{
    self.name = name;
    self.phone = phone;
    self.address = address;
    self.site = site;
}

-(NSString *) description{
    return [NSString stringWithFormat:
            @"Nome:%@, Telefone:%@, Endereco:%@, Site:%@",
            self.name, self.phone, self.address, self.site];
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.lat doubleValue],
                                      [self.lng doubleValue]);
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.phone;
}

@end
