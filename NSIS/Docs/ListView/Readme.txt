

All macros in this header:

1. NSD_RemoveStyle
#################################################################
# ${NSD_RemoveStyle} hWnd Styles                                #
# Removes one or more window styles from a control              #
#################################################################

2. NSD_RemoveExStyle
#################################################################
# ${NSD_RemoveExStyle} hWnd ExStyles                            #
# Removes one or more extended window styles from a control     #
#################################################################

3. NSD_CB_DelString
#################################################################
# ${NSD_CB_DelString} hComboBox String                          #
# Deletes the specified string from a ComboBox                  #
#################################################################

4. NSD_CB_Clear
#################################################################
# ${NSD_CB_Clear} hComboBox                                     #
# Deletes all strings from a ComboBox control (no return value) #
#################################################################

5. NSD_CB_GetCount
#################################################################
# ${NSD_CB_GetCount} hComboBox outVar                           #
# Retrieves the number of strings from a ComboBox control       #
#################################################################

6. NSD_CB_GetSelection
#################################################################
# ${NSD_CB_GetSelection} hComboBox outVar                       #
# Retrieves the selected string from a ComboBox control         #
#################################################################

7. NSD_LB_DelString
#################################################################
# ${NSD_LB_DelString} hListBox String                           #
# Deletes the specified string from a ListBox control           #
#################################################################
In fact, the macro "NSD_LB_DelString" in nsDialogs always deletes
the first string but not the specified one.  I write a new one to
replace it, and undefine the original one.

8. NSD_LB_Clear
#################################################################
# ${NSD_LB_Clear} hListBox                                      #
# Deletes all strings from a ListBox control (no return value)  #
#################################################################
In fact, the macro NSD_LB_Clear in header nsDialogs.nsh needs two
parameters, but the readme file of nsDialogs said the macro needs
only one parameter, it is exactly the handle of the listbox. This
macro is redefined as the above one, it doesn't return a value.


Using ${NSD_CreateListView} macro to create a ListView control.

9. NSD_LV_InsertColumn
#################################################################
# ${NSD_LV_InsertColumn} hListView iCol cx szText               #
# Inserts a new column to a ListView (report view only)         #
#################################################################

10. NSD_LV_DeleteColumn
#################################################################
# ${NSD_LV_DeleteColumn} hListView iCol                         #
# Deletes the column of specified index (report view only)      #
#################################################################

11. NSD_LV_InsertItem
#################################################################
# ${NSD_LV_InsertItem} hListView iItem szText                   #
# Inserts a new item to a ListView                              #
#################################################################

12. NSD_LV_DeleteItem
#################################################################
# ${NSD_LV_DeleteItem} hListView iItem                          #
# Deletes the item of specified index                           #
#################################################################

13. NSD_LV_GetItemText
#################################################################
# ${NSD_LV_GetItemText} hListView iItem iSubItem outVar         #
# Retrieves the text of an item of a ListView                   #
# Note: Parameter iSubItem is available in report view only     #
#################################################################

14. NSD_LV_SetItemText
#################################################################
# ${NSD_LV_SetItemText} hListView iItem iSubItem szText         #
# Sets the text of an item or subitem of ListView               #
# Note: Parameter iSubItem is available in report view only     #
#################################################################

15. NSD_LV_SetItemImage
#################################################################
# ${NSD_LV_SetItemImage} hListView iItem iImage                 #
# Sets the icon index of an item of ListView                    #
#################################################################

16. NSD_LV_GetCheckState
#################################################################
# ${NSD_LV_GetCheckState} hListView iItem State                 #
# Gets the item's check state of ListView with checkboxes style #
#################################################################

17. NSD_LV_SetCheckState
#################################################################
# ${NSD_LV_SetCheckState} hListView iItem State                 #
# Sets the item's check state of ListView with checkboxes style #
#################################################################

See examples for usage.

More information about ListView styles at:
http://msdn.microsoft.com/library/bb774739.aspx
About extended ListView styles:
http://msdn.microsoft.com/library/bb774732.aspx