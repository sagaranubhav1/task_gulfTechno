import 'package:flutter/material.dart';
import 'package:task_gulftechno/models/ProductModel.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var productData = [
    ProductModel(
        category: "Electronics", price: 32000, size: 2, name: "Mobiles"),
    ProductModel(
        category: "Clothing",
        price: 10000,
        size: 3,
        name: "Blazers and Trousers"),
    ProductModel(category: "Food", price: 500, size: 10, name: "Burger"),
    ProductModel(category: "Footwear", price: 2500, size: 12, name: "Shoes"),
    ProductModel(
        category: "Books", price: 2000, size: 4, name: "Data Structure"),
    ProductModel(
        category: "Watches", price: 600, size: 6, name: "Analog Watch"),
    ProductModel(category: "Toys", price: 1500, size: 2, name: "Lego Set"),
  ];

  var priceList = ["32000", "10000", "500", "2500", "2000", "600", "1500"];
  var sizeList = ["2", "3", "10", "12", "4", "6", "2"];

  List<ProductModel> filteredProductList = [];
  int MaxPrice=0, MinPrice=0, MinSize=0, MaxSize=0;
  String maxPrice='35000',minPrice='1',minSize='1',maxSize='12';



  RangeValues values1;
  RangeValues values2;
   RangeLabels rangePriceLabels;
   RangeLabels rangeSizeLabels;


  var priceBoolList = [];
  var sizeBoolList = [];
  var listToSend = [];

  @override
  void initState() {
    super.initState();
    values1 = RangeValues(double.parse(minPrice), double.parse(maxPrice));
    values2 = RangeValues(double.parse(minSize), double.parse(maxSize));
    rangePriceLabels = RangeLabels(minPrice, maxPrice);
    rangeSizeLabels = RangeLabels(minSize, maxSize);

    prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Screen",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 15),
            padding: const EdgeInsets.only(left: 20, right: 8),
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(width: 0),
              color: Colors.white,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 300), () {

                  filteredProductList = productData
                      .where((data) =>
                  (data.name
                      .trim()
                      .toLowerCase()
                      .contains(value.trim().toLowerCase())||data.category
                      .trim()
                      .toLowerCase()
                      .contains(value.trim().toLowerCase())))
                      .toList();

                  setState(() {});
                });
              },
              onSubmitted: (value) {},
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "Search Product by Name/Category",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text(
              'Price Filter',
              textScaleFactor: 1.0,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          ),
          RangeSlider(
            min: double.parse(minPrice),
            max:  double.parse(maxPrice),
            divisions: 200,
            labels: rangePriceLabels,
            values: values1,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                values1 = value;
                rangePriceLabels = RangeLabels(
                    '\₹${value.start.toInt().toString()}',
                    '\₹${value.end.toInt().toString()}');


                print("==="+ values1.toString());
                print("==="+ value.start.toInt().toString());
                print("==="+ value.end.toInt().toString());


                MaxPrice = value.end.toInt();
                MinPrice = value.start.toInt();

                if(MaxSize!=0 && MinSize!=0){
                  filteredProductList = productData
                      .where((data) =>
                  (data.price>MinPrice && data.price<MaxPrice) &&(data.size>MinSize && data.size<MaxSize) )
                      .toList();
                }
                else{
                  filteredProductList = productData
                      .where((data) =>
                  (data.price>MinPrice && data.price<MaxPrice))
                      .toList();
                }

              });
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text(
              'Size Filter',
              textScaleFactor: 1.0,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          ),
          RangeSlider(
            min: double.parse(minSize),
            max:  double.parse(maxSize),
            divisions: 200,
            labels: rangeSizeLabels,
            values: values2,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                values2 = value;
                rangeSizeLabels = RangeLabels(value.start.toInt().toString(), value.end.toInt().toString());
                print("==="+ values2.toString());
                print("==="+ value.start.toInt().toString());
                print("==="+ value.end.toInt().toString());
                MaxSize = value.end.toInt();
                MinSize = value.start.toInt();

                if(MinPrice!=0 && MaxPrice!=0){
                  filteredProductList = productData
                      .where((data) =>
                  (data.size>MinSize && data.size<MaxSize)&&(data.price>MinPrice && data.price<MaxPrice))
                      .toList();
                }
                else{
                  filteredProductList = productData
                      .where((data) =>
                  (data.size>MinSize && data.size<MaxSize))
                      .toList();
                }

              });
            },
          ),

          Expanded(
              child: filteredProductList != null &&
                  filteredProductList.length > 0 ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: filteredProductList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return productItemView(index);
                  }) : Center(
                child: Text(
                  "No Record(s) Found",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
          ),
        ],
      ),
    );
  }

  void prepareData() {
    for (int i = 0; i < productData.length; i++) {
      filteredProductList.add(ProductModel(
        name: productData[i].name,
        size: productData[i].size,
        price: productData[i].price,
        category: productData[i].category,
      ));
    }

    for (int i = 0; i < priceList.length; i++) {
      priceBoolList.add(false);
    }

    for (int i = 0; i < sizeList.length; i++) {
      sizeBoolList.add(false);
    }
  }

  Widget productItemView(int index) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  Text(
                    "Category:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    filteredProductList[index].category,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    filteredProductList[index].name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    children: [
                      Text(
                        "Size:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        filteredProductList[index].size.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Price:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "₹" + filteredProductList[index].price.toString(),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
