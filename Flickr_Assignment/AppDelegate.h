//
//  AppDelegate.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/6/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

