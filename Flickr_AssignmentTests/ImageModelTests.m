//
//  ImageModelTests.m
//  Flickr_AssignmentTests
//
//  Created by Xin Chen on 6/8/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageModel.h"
#import "Header.h"

NSString * const  _Nonnull flickrURL = @"https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=9dc46dc917884944fbd2ab47f296971c&format=json&nojsoncallback=1&";
@interface ImageModelTests : XCTestCase
@property (nonatomic, strong) NSMutableArray  * imageModels;

@end

@implementation ImageModelTests

- (void)setUp {

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
-(void)testGetImageList{
    id expectation =[self expectationWithDescription:@"getImageList completed"];
    [ImageModel getImageList:flickrURL Page:1 Per_Page:20 ImageCallBack:^(NSArray * _Nonnull imageModelArray) {
        [self.imageModels addObjectsFromArray:imageModelArray];
        [expectation fulfill];
        XCTAssertTrue(self.imageModels.count == 20);

    } ];


   
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)");
        }
    }];
    
    
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
- (NSMutableArray *)imageModels{
    if (!_imageModels) {
        _imageModels = [NSMutableArray array];
    }
    return _imageModels;
}

@end
