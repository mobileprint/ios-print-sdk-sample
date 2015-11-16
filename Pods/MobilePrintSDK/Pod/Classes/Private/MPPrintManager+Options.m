//
// HP Inc.
// All rights reserved.
//
// This file, its contents, concepts, methods, behavior, and operation
// (collectively the "Software") are protected by trade secret, patent,
// and copyright laws. The use of the Software is governed by a license
// agreement. Disclosure of the Software to third parties, in any form,
// in whole or in part, is expressly prohibited except as authorized by
// the license agreement.
//

#import "MP.h"
#import "MPPrintManager.h"
#import "MPPrintManager+Options.h"
#import <objc/runtime.h>

// The following technique is adapted from:  http://stackoverflow.com/questions/8733104/objective-c-property-instance-variable-in-category

@implementation MPPrintManager (Options)

NSString * const kMPPrinterDetailsNotAvailable = @"Not Available";

- (void)setOptions:(MPPrintManagerOptions)options
{
    NSNumber *optionsAsNumber = [NSNumber numberWithUnsignedLong:options];
    objc_setAssociatedObject(self, @selector(options), optionsAsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MPPrintManagerOptions)options
{
    NSNumber *optionsAsNumber = objc_getAssociatedObject(self, @selector(options));
    return [optionsAsNumber unsignedLongValue];
}

- (void)setNumberOfCopies:(NSInteger)numberOfCopies
{
    NSNumber *copiesAsNumber = [NSNumber numberWithInteger:numberOfCopies];
    objc_setAssociatedObject(self, @selector(numberOfCopies), copiesAsNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)numberOfCopies
{
    NSNumber *copiesAsNumber = objc_getAssociatedObject(self, @selector(numberOfCopies));
    return [copiesAsNumber integerValue];
}

- (void)saveLastOptionsForPrinter:(NSString *)printerID;
{
    NSMutableDictionary *lastOptionsUsed = [NSMutableDictionary dictionaryWithDictionary:[MP sharedInstance].lastOptionsUsed];
    [lastOptionsUsed setValue:self.currentPrintSettings.paper.typeTitle forKey:kMPPaperTypeId];
    [lastOptionsUsed setValue:self.currentPrintSettings.paper.sizeTitle forKey:kMPPaperSizeId];
    [lastOptionsUsed setValue:[NSNumber numberWithFloat:self.currentPrintSettings.paper.width] forKey:kMPPaperWidthId];
    [lastOptionsUsed setValue:[NSNumber numberWithFloat:self.currentPrintSettings.paper.height] forKey:kMPPaperHeightId];
    [lastOptionsUsed setValue:[NSNumber numberWithBool:!self.currentPrintSettings.color] forKey:kMPBlackAndWhiteFilterId];
    [lastOptionsUsed setValue:[NSNumber numberWithInteger:self.numberOfCopies] forKey:kMPNumberOfCopies];
    
    [lastOptionsUsed setValue:kMPPrinterDetailsNotAvailable forKey:kMPPrinterDisplayName];
    [lastOptionsUsed setValue:kMPPrinterDetailsNotAvailable forKey:kMPPrinterDisplayLocation];
    [lastOptionsUsed setValue:kMPPrinterDetailsNotAvailable forKey:kMPPrinterMakeAndModel];
    
    if (printerID) {
        [lastOptionsUsed setValue:printerID forKey:kMPPrinterId];
        if ([printerID isEqualToString:self.currentPrintSettings.printerUrl.absoluteString]) {
            [lastOptionsUsed setValue:self.currentPrintSettings.printerName forKey:kMPPrinterDisplayName];
            [lastOptionsUsed setValue:self.currentPrintSettings.printerLocation forKey:kMPPrinterDisplayLocation];
            [lastOptionsUsed setValue:self.currentPrintSettings.printerModel forKey:kMPPrinterMakeAndModel];
        }
    }
    
    [MP sharedInstance].lastOptionsUsed = [NSDictionary dictionaryWithDictionary:lastOptionsUsed];
}

- (void)saveLastOptionsForPaper:(UIPrintPaper *)paper
{
    NSMutableDictionary *lastOptionsUsed = [NSMutableDictionary dictionaryWithDictionary:[MP sharedInstance].lastOptionsUsed];

    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.paperSize.width] forKey:kMPPrinterPaperWidthPoints];
    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.paperSize.height] forKey:kMPPrinterPaperHeightPoints];
    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.printableRect.size.width] forKey:kMPPrinterPaperAreaWidthPoints];
    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.printableRect.size.height] forKey:kMPPrinterPaperAreaHeightPoints];
    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.printableRect.origin.x] forKey:kMPPrinterPaperAreaXPoints];
    [lastOptionsUsed setValue:[NSString stringWithFormat:@"%.0f", paper.printableRect.origin.y] forKey:kMPPrinterPaperAreaYPoints];

    [MP sharedInstance].lastOptionsUsed = [NSDictionary dictionaryWithDictionary:lastOptionsUsed];
}

@end
