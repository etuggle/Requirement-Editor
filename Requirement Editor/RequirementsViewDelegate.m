//
//  RequirementsViewDelegate.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/14/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "RequirementsViewDelegate.h"

#define SINGLE_LINE_HEIGHT  17


@implementation RequirementsViewDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectedRow = -1;
    }
    return self;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    //notification.
    NSTableView *tView = notification.object;
    //NSLog(@"received notification: %@ for row %ld", notification.name, tView.selectedRow);

    [tView setNeedsDisplay:YES];
    long row;
    if (tView.selectedRow == -1) {
        row = _selectedRow;
        _selectedRow = -1;
    } else {
        _selectedRow = tView.selectedRow;
        row = _selectedRow;
    }
    NSIndexSet *idx = [[NSIndexSet alloc] initWithIndex:row];
    [tView noteHeightOfRowsWithIndexesChanged:idx];
}

- (CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger) row {
    RequirementsDataSource *ds = [tableView dataSource];
    
    Requirement *r = [ds.requirements objectAtIndex:row];
    CGFloat height;
    
    
    NSTableColumn *tc = [tableView tableColumnWithIdentifier:@"Description"];
    
    NSTextFieldCell *textField = tc.dataCell;
    NSRect rect;
    CGSize foo;
    foo.width = [tc width];
    rect.size = foo;
    NSSize cellSize = [textField cellSize];
    cellSize = [textField cellSizeForBounds:(NSRect)rect];

    NSFont *font = textField.font;
    CGFloat pointSize = font.pointSize;
    
    height = (r.mDescription.length / ([tc width] / pointSize)) * 17;
    
    //NSLog(@"Computed size: height: %f width:%f column width: %f", cellSize.height, cellSize.width, [tc width]);
    
    /*
    if ((tableView.selectedRow == row) && (_selectedRow != -1)) {
        height =  50;
    } else {
        height = SINGLE_LINE_HEIGHT;
    }
     */
    //if (r.mDescription.length >  73) {
    //    height = 50;
    //} else {
    //    height = 17;
    //}
    //NSLog(@"row: %ld length: %ld returns %f", (long)row, r.mDescription.length, height);
    //NSLog(@"%@", r.mDescription);
    return 69;
}
@end
