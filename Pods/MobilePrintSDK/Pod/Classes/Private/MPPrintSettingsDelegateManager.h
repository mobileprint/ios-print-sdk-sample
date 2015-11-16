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

#import <Foundation/Foundation.h>
#import "MPPrintSettings.h"
#import "MPPrintItem.h"

#import "MPPageRangeKeyboardView.h"
#import "MPPrintSettingsTableViewController.h"
#import "MPPaperSizeTableViewController.h"
#import "MPPaperTypeTableViewController.h"

#import "MPPageSettingsTableViewController.h"

/*!
 * @abstract This class takes the burden of data change events, data storage, 
 *  and data manipulation out of the print-related view controllers and places
 *  it in a single, re-usable location.
 */
@interface MPPrintSettingsDelegateManager : NSObject
    <MPPageRangeKeyboardViewDelegate,
     MPPrintSettingsTableViewControllerDelegate,
     MPPaperSizeTableViewControllerDelegate,
     MPPaperTypeTableViewControllerDelegate,
     UIPrinterPickerControllerDelegate>

/*!
 * @abstract The view controller using the delegate manager.
 * @discussion Later, this will be modified such that it's a special type of UIViewController
 */
@property (weak, nonatomic) MPPageSettingsTableViewController *pageSettingsViewController;

/*!
 * @abstract The print settings to be used in the print job
 */
@property (strong, nonatomic) MPPrintSettings *printSettings;

/*!
 * @abstract The print item to be used in the print job
 */
@property (strong, nonatomic) MPPrintItem *printItem;

/*!
 * @abstract The page range to be used in the print job
 */
@property (strong, nonatomic) MPPageRange *pageRange;

/*!
 * @abstract The name associated with the print job (for print queue jobs only)
 */
@property (strong, nonatomic) NSString *jobName;

/*!
 * @abstract The number of copies to be generated by the print job
 */
@property (assign, nonatomic) NSInteger numCopies;

/*!
 * @abstract If TRUE, the print will be made in black and white
 */
@property (assign, nonatomic) BOOL blackAndWhite;

/*!
 * @abstract The paper to be used by the print job
 */
@property (strong, nonatomic) MPPaper *paper;

/*!
 * @abstract The text to be used on a print button
 */
@property (strong, nonatomic) NSString *printLabelText;

/*!
 * @abstract The text to be used on an "Add to Print Queue" button
 */
@property (strong, nonatomic) NSString *printLaterLabelText;

/*!
 * @abstract The text to be used to convey the number of copies to produced by the print job
 */
@property (strong, nonatomic) NSString *numCopiesLabelText;

/*!
 * @abstract The text to be used to summarize the characteristics of the print job
 */
@property (strong, nonatomic) NSString *printJobSummaryText;

/*!
 * @abstract The text to be used to summarize the characteristics of the print-later job
 */
@property (strong, nonatomic) NSString *printLaterJobSummaryText;

/*!
 * @abstract The text to be used to convey the page range to be used in the print job
 */
@property (strong, nonatomic) NSString *pageRangeText;

/*!
 * @abstract The text used to display the printer's name to a user
 */
@property (strong, nonatomic) NSString *selectedPrinterText;

/*!
 * @abstract The text summarizing the printer name, paper size, and paper type
 */
@property (strong, nonatomic) NSString *printSettingsText;

/*!
 * @abstract Returns TRUE if the page range includes all pages, and only all pages
 */
- (BOOL)allPagesSelected;

/*!
 * @abstract Returns TRUE if the page range includes no pages
 */
- (BOOL)noPagesSelected;

/*!
 * @abstract Allows the page range to be modified based on including or excluding a single page number
 * @param includePage If TRUE, the page will be added to the page range.  If FALSE, the page will be removed.
 * @param pageNumber The page number to include or exclude from the page range
 */
- (void)includePageInPageRange:(BOOL)includePage pageNumber:(NSInteger)pageNumber;

/*!
 * @abstract Loads the last used print options into currentPrintSettings
 */
- (void)loadLastUsed;

/*!
 * @abstract Sets the last used print options with the user's current selections
 * @param printId the printer ID to use in the last used print options
 */
- (void)savePrinterId:(NSString *)printerId;

+ (MPPaper *)lastPaperUsed;

@end
