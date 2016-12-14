//
//  MapDirection.h
//  Hello Cabs
//
//  Created by Prem Kumar on 07/12/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
@interface MapDirection : UIView<MKMapViewDelegate>
{
    MKMapView* mapView;
    NSArray* routes;
    BOOL isUpdatingRoutes;
}


@end
