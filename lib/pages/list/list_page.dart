import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/pages/products/_products.dart' show BroProductsDrawer;
import 'package:brokali/blocs/products_bloc.dart';
import 'package:brokali/blocs/stacks_bloc.dart';
import 'package:brokali/models/_models.dart'
    show BroStackModel, BroStackListItemModel, BroProductModel;
import 'package:brokali/utils/_utils.dart' show BroProductDictionary;
import 'package:brokali/pages/common/_common.dart' show BroTextInputController;

import '_list.dart';

class BroListPage extends StatefulWidget {
  final BroStackModel model;

  BroListPage(this.model);

  @override
  _BroListPageState createState() => _BroListPageState();
}

class _BroListPageState extends State<BroListPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  BroTextInputController ctrlInput;
  StreamController<BroListInputText> strmInputText;

  bool isPurchased = false;
  bool showActionButtons = true;
  bool showInput = false;

  List<BroStackListItemModel> stackList;
  BroStacksBloc stacksBloc;
  BroProductDictionary productDict;

  @override
  void initState() {
    super.initState();

    ctrlInput = BroTextInputController();
    ctrlInput.text = '';

    strmInputText = StreamController<BroListInputText>.broadcast();
    strmInputText.stream.listen((BroListInputText inputText) {
      ctrlInput.text = inputText.value;
    });

    stackList = widget.model.list;

    if (widget.model.purchased) {
      showActionButtons = false;
      isPurchased = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    stacksBloc = BlocProvider.of<BroStacksBloc>(context);
    productDict = BroProductDictionary(
        BlocProvider.of<BroProductsBloc>(context).getDataValue());

    return Scaffold(
      key: scaffoldKey,
      endDrawer: BroProductsDrawer(productDict, handleAddProductToTextInput),
      resizeToAvoidBottomPadding: true,
      appBar: BroListAppBar(widget.model),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onDoubleTap: () => turnOffInputMode(),
            child: Container(
              color: showInput ? Colors.black26 : Colors.white,
              child: Opacity(
                opacity: showInput ? 0.5 : 1,
                child: BroListView(
                  isPurchased: isPurchased,
                  showInput: showInput,
                  stackList: stackList,
                  onSelect: handleTogglePurchaseStatus,
                  onDismissed: handleDeleteListItem,
                  onEditResult: () {
                    setState(
                      () {
                        showActionButtons = true;
                        isPurchased = false;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 50.0),
              child: showInput
                  ? BroListTags(
                      strmInputText: strmInputText,
                      productDict: productDict,
                    )
                  : Container(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: showInput
                ? BroListInput(
                    ctrlInput: ctrlInput,
                    strmInputText: strmInputText,
                    onAddProduct: handleAddProduct,
                    onHideInput: () => turnOffInputMode(),
                  )
                : Container(),
          ),
        ],
      ),
      floatingActionButton: showActionButtons
          ? BroListActionButtons(() {
              handleToogleInput(true);
              handleToggleActionButtons(false);
            }, () => handleToggleProductView())
          : Container(),
    );
  }

  void turnOffInputMode() async {
    handleToogleInput(false);

    await Future<void>.delayed(Duration(milliseconds: 300));
    handleToggleActionButtons(true);
  }

  void handleToogleInput(status) {
    setState(() => showInput = status);
  }

  void handleToggleActionButtons(status) {
    setState(() => showActionButtons = status);
  }

  void handleAddProduct(BroListInputText inputText) async {
    BroProductModel product = productDict.findProductByLabel(inputText.product);
    BroStackListItemModel listItem = BroStackListItemModel.build(
      id: Uuid().v1(),
      productId: product?.id,
      productUnit: product?.unit,
      label: inputText.product,
      package: inputText.package,
      qty: inputText.qty,
      purchased: false,
    );

    setState(() {
      stackList = [listItem] + stackList;
    });

    updateStackList();
  }

  void handleAddProductToTextInput(BroProductModel model) {
    handleToogleInput(true);
    handleToggleActionButtons(false);

    strmInputText.add(BroListInputText(model.label));
  }

  void handleTogglePurchaseStatus(String stackListId) {
    setState(() {
      stackList = stackList.map((list) {
        if (list.id == stackListId) {
          list.purchased = !list.purchased;
        }
        return list;
      }).toList();

      showActionButtons = !widget.model.purchased;
      isPurchased = widget.model.purchased;
    });

    updateStackList();
  }

  void handleDeleteListItem(int index) {
    setState(() {
      stackList.removeAt(index);
    });

    updateStackList();
  }

  void updateStackList() {
    Map data = widget.model.data;
    data['list'] = stackList.map((list) => list.data).toList();
    stacksBloc.dispatch(BroStacksUpdateInDataEvent(stack: BroStackModel(data)));
    stacksBloc.dispatch(BroStacksUpdateInRepoEvent(stack: BroStackModel(data)));
  }

  void handleToggleProductView() {
    scaffoldKey.currentState.openEndDrawer();
  }

  @override
  void dispose() {
    ctrlInput.dispose();
    strmInputText.close();

    super.dispose();
  }
}
