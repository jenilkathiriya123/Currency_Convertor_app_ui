import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Helper_page/CurrencyHelper.dart';
import '../../Model/Currency.dart';
import '../../main.dart';
import 'Global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Currency?> money;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    money = CurrencyHelper.currencyHelper
        .CurrencyData(from: "USD", to: "INR", amount: 1);

    amountController.text = "1";
  }

  String fromCurrency = "USD";
  String toCurrency = "INR";

  @override
  Widget build(BuildContext context) {
    return (Globals.isIos == false)
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                "Currency Convertor",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color(0xffACBB78),
              actions: [
                Switch(
                  onChanged: (val) {
                    Globals.isIos = val;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false);
                  },
                  value: Globals.isIos,
                ),
              ],
            ),
            body: Container(
              
              child: FutureBuilder(
                  future: money,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      Currency? data = snapshot.data as Currency?;
                      return (data != null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Enter Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80),
                                    child: TextField(
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "From",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: DropdownButtonFormField(
                                            value: fromCurrency,
                                            items: Globals.currency
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                fromCurrency = val!.toString();
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(Icons.arrow_downward_outlined),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "To",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: DropdownButtonFormField(
                                            value: toCurrency,
                                            items: Globals.currency
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                toCurrency = val!.toString();
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(
                                                3.0,
                                                3.0,
                                              ),
                                              blurRadius: 7.0,
                                              // spreadRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Rate :",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${data.rate}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Container(
                                          height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  3.0,
                                                  3.0,
                                                ),
                                                blurRadius: 7.0,
                                                // spreadRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Results:",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${data.result}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: ElevatedButton(
                                      style: (ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color(0xffACBB78),
                                        ),
                                      )),
                                      onPressed: () {
                                        if (amountController.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content:
                                                  Text("Please Enter Amount"),
                                            ),
                                          );
                                        } else {
                                          int amount =
                                              int.parse(amountController.text);
                                          setState(() {
                                            money = CurrencyHelper
                                                .currencyHelper
                                                .CurrencyData(
                                                    from: fromCurrency,
                                                    to: toCurrency,
                                                    amount: amount);
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Convert",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text("No Data Found"),
                            );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          )
        : CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffF7F8F8),
                ),
              ),
              trailing: CupertinoSwitch(
                  value: Globals.isIos,
                  onChanged: (val) {
                    Globals.isIos = val;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false);
                  }),
              middle: const Text("Currency Convertor"),
            ),
            child: Container(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffF7F8F8),
                      Color(0xffACBB78),
                    ],
                  ),
                ),
                child: FutureBuilder(
                    future: money,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        Currency? data = snapshot.data as Currency?;
                        return (data != null)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 120),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Enter Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 40),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 100),
                                        child: CupertinoTextField(
                                          controller: amountController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: const Text(
                                            "From",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) => Column(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        color: Colors.black26,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CupertinoPicker(
                                                      backgroundColor:
                                                          Colors.white,
                                                      itemExtent: 30,
                                                      children: Globals.currency
                                                          .map((e) {
                                                        return Text(
                                                          e,
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onSelectedItemChanged:
                                                          (value) {
                                                        setState(() {
                                                          fromCurrency = Globals
                                                              .currency[value];
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            height: 40,
                                            width: 60,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  fromCurrency,
                                                ),
                                                const Icon(
                                                  CupertinoIcons.add_circled,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_downward),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "To",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) => Column(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        color: Colors.black26,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CupertinoPicker(
                                                      backgroundColor:
                                                          Colors.white,
                                                      itemExtent: 30,
                                                      children: Globals.currency
                                                          .map((e) {
                                                        return Text(
                                                          e,
                                                          style: TextStyle(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onSelectedItemChanged:
                                                          (value) {
                                                        setState(() {
                                                          toCurrency = Globals
                                                              .currency[value];
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  toCurrency,
                                                ),
                                                const Icon(
                                                  CupertinoIcons.add_circled,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  3.0,
                                                  3.0,
                                                ),
                                                blurRadius: 7.0,
                                                // spreadRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Rate :",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${data.rate}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Container(
                                            height: 100,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(
                                                    3.0,
                                                    3.0,
                                                  ),
                                                  blurRadius: 7.0,
                                                  // spreadRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Results:",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${data.result}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: CupertinoButton(
                                        onPressed: () {
                                          if (amountController.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content:
                                                    Text("Please Enter Amount"),
                                              ),
                                            );
                                          } else {
                                            int amount = int.parse(
                                                amountController.text);
                                            setState(() {
                                              money = CurrencyHelper
                                                  .currencyHelper
                                                  .CurrencyData(
                                                      from: fromCurrency,
                                                      to: toCurrency,
                                                      amount: amount);
                                            });
                                          }
                                        },
                                        child: const Text(
                                          "Convert",
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(
                                child: Text("Data Not Found"),
                              );
                      }
                      return const Center(
                        child: CupertinoActivityIndicator(radius: 15),
                      );
                    }),
              ),
            ),
          );
  }
}
