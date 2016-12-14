//
//  Annotation.h
//  NearBy
//
//  Created by SYZYGY01 on 23/11/15.
//  Copyright © 2015 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Annotation : NSObject

@property (nonatomic)CLLocationCoordinate2D coordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordChk;

@end
