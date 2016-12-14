//
//  Annotation.m
//  NearBy
//
//  Created by SYZYGY01 on 23/11/15.
//  Copyright © 2015 Syzygy. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate;


-(id)initWithCoordinate:(CLLocationCoordinate2D) coordChk
{
    self.coordinate=coordChk;
    return self;
}



@end
