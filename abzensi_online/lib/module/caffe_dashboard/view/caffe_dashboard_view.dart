import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/caffe_dashboard_controller.dart';

class CaffeDashboardView extends StatefulWidget {
  const CaffeDashboardView({Key? key}) : super(key: key);

  Widget build(context, CaffeDashboardController controller) {
    controller.view = this;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xff1a1a1a),
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('SliverAppBar'),
            ),
            pinned: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xff1a1a1a),
                    ),
                  ),
                  Container(
                    height: 100,
                    transform: Matrix4.translationValues(0.0, -30, 0),
                    margin: const EdgeInsets.only(top: 100.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 24,
                          offset: Offset(0, 11),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30.0,
                    right: 30.0,
                    top: 20.0,
                    bottom: 20.0,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 24,
                            offset: Offset(0, 11),
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1604184811623-129a299b1322?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2126&q=80",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<CaffeDashboardView> createState() => CaffeDashboardController();
}
