import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown {
  /// This gives the button text or it sets default text as 'click me'.
  final String? buttonText;

  /// This gives the bottom sheet title.
  final String? bottomSheetTitle;

  /// This will give the submit button text.
  final String? submitButtonText;

  /// This will give the submit button background color.
  final Color? submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This will give the default search controller to the search text field.
  final TextEditingController searchController;

  /// This will give the list of data.
  final List<SelectedListItem> dataList;

  /// This will give the call back to the selected items (multiple) from list.
  final Function(List<dynamic>)? selectedItems;

  /// This will give the call back to the selected item (single) from list.
  final Function(String)? selectedItem;

  /// This will give selection choise for single or multiple for list.
  final bool enableMultipleSelection;

  final dynamic? groupValue;

  DropDown({
    Key? key,
    this.buttonText,
    this.bottomSheetTitle,
    this.submitButtonText,
    this.submitButtonColor,
    this.searchHintText,
    this.searchBackgroundColor,
    required this.searchController,
    required this.dataList,
    this.selectedItems,
    this.selectedItem,
    required this.enableMultipleSelection,
    this.groupValue,
  });
}

class DropDownState {
  DropDown dropDown;

  DropDownState(this.dropDown);

  /// This gives the bottom sheet widget.
  void showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MainBody(
              dropDown: dropDown,
            );
          },
        );
      },
    );
  }
}

/// This is Model class. Using this model class, you can add the list of data with title and its selection.
class SelectedListItem {
  bool isSelected;
  String name;
  String? value;

  SelectedListItem(this.isSelected, this.name, {this.value});
}

/// This is main class to display the bottom sheet body.
class MainBody extends StatefulWidget {
  DropDown dropDown;

  MainBody({required this.dropDown, Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  /// This list will set when the list of data is not available.
  List<SelectedListItem> mainList = [];

  @override
  void initState() {
    super.initState();
    mainList = widget.dropDown.dataList;
    groupValue = widget.dropDown.groupValue;
  }

  dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.13,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Bottom sheet title text
                  Text(
                    widget.dropDown.bottomSheetTitle ?? 'Title',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),

                  /// Done button
                  Visibility(
                    visible: widget.dropDown.enableMultipleSelection,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            List<SelectedListItem> selectedList = widget
                                .dropDown.dataList
                                .where((element) => element.isSelected == true)
                                .toList();
                            List<String> selectedNameList = [];

                            for (var element in selectedList) {
                              selectedNameList
                                  .add(element.value ?? element.name);
                            }

                            widget.dropDown.selectedItems
                                ?.call(selectedNameList);
                            _onUnfocusKeyboardAndPop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: widget.dropDown.submitButtonColor ??
                                Colors.blue,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child:
                              Text(widget.dropDown.submitButtonText ?? 'Done')),
                    ),
                  ),
                ],
              ),
            ),

            /// Listview (list of data with check box for multiple selection & on tile tap single selection)
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: mainList.length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    title: Text(
                      mainList[index].name
                    ),
                    value: int.parse(mainList[index].value!),
                    groupValue: groupValue,
                    onChanged: (int? value) {
                      widget.dropDown.selectedItem?.call(
                          (value != null)
                              ? '$value' ?? ''
                              : mainList[index].name);
                      // _onUnfocusKeyboardAndPop();
                    },
                  );

                  InkWell(
                    onTap: widget.dropDown.enableMultipleSelection
                        ? null
                        : () {
                            widget.dropDown.selectedItem?.call(
                                (mainList[index].value != null)
                                    ? mainList[index].value ?? ''
                                    : mainList[index].name);
                            _onUnfocusKeyboardAndPop();
                          },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: ListTile(
                          title: Text(
                            mainList[index].name,
                          ),
                          trailing: widget.dropDown.enableMultipleSelection
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      mainList[index].isSelected =
                                          !mainList[index].isSelected;
                                    });
                                  },
                                  child: mainList[index].isSelected
                                      ? const Icon(Icons.check_box)
                                      : const Icon(
                                          Icons.check_box_outline_blank),
                                )
                              : const SizedBox(
                                  height: 0.0,
                                  width: 0.0,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// This helps to unfocus the keyboard & pop from the bottom sheet.
  _onUnfocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }
}
