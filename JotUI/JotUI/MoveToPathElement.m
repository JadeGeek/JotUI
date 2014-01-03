//
//  DotSegment.m
//  JotUI
//
//  Created by Adam Wulf on 12/19/12.
//  Copyright (c) 2012 Adonit. All rights reserved.
//

#import "MoveToPathElement.h"
#import "AbstractBezierPathElement-Protected.h"

@implementation MoveToPathElement{
    // cache the hash, since it's expenseive to calculate
    NSUInteger hashCache;
}

-(id) initWithMoveTo:(CGPoint)_point{
    if(self = [super initWithStart:_point]){
        NSUInteger prime = 31;
        hashCache = 1;
        hashCache = prime * hashCache + startPoint.x;
        hashCache = prime * hashCache + startPoint.y;
    }
    return self;
}

+(id) elementWithMoveTo:(CGPoint)point{
    return [[MoveToPathElement alloc] initWithMoveTo:point];
}

/**
 * we're just 1 point, so we have zero length
 */
-(CGFloat) lengthOfElement{
    return 0;
}

-(CGFloat) angleOfStart{
    return 0;
}

-(CGFloat) angleOfEnd{
    return 0;
}

-(CGRect) bounds{
    return CGRectInset(CGRectMake(startPoint.x, startPoint.y, 0, 0), -width, -width);
}

-(CGPoint) endPoint{
    return self.startPoint;
}

-(void) adjustStartBy:(CGPoint)adjustment{
    startPoint = CGPointMake(startPoint.x + adjustment.x, startPoint.y + adjustment.y);
}

/**
 * only 1 step to show our single point
 */
-(NSInteger) numberOfSteps{
    return 0;
}

-(NSInteger) numberOfBytesGivenPreviousElement:(AbstractBezierPathElement*)previousElement{
    return 0;
}

-(struct ColorfulVertex*) generatedVertexArrayWithPreviousElement:(AbstractBezierPathElement*)previousElement forScale:(CGFloat)scale{
    return NULL;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"[Move to: %f,%f]", startPoint.x, startPoint.y];
}

#pragma mark - PlistSaving

-(id) initFromDictionary:(NSDictionary*)dictionary{
    if (self = [super initFromDictionary:dictionary]) {
        NSUInteger prime = 31;
        hashCache = 1;
        hashCache = prime * hashCache + startPoint.x;
        hashCache = prime * hashCache + startPoint.y;
    }
    return self;
}

-(void) validateDataGivenPreviousElement:(AbstractBezierPathElement*)previousElement{
    // noop, we don't have data
}

-(UIBezierPath*) bezierPathSegment{
    UIBezierPath* strokePath = [UIBezierPath bezierPath];
    [strokePath moveToPoint:self.startPoint];
    return strokePath;
}


#pragma mark - hashing and equality

-(NSUInteger) hash{
    return hashCache;
}

-(BOOL) isEqual:(id)object{
    return self == object || [self hash] == [object hash];
}

@end
