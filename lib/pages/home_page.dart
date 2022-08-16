import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testscout/bloc/bloc/home_bloc_bloc.dart';
import 'package:testscout/routes/routes.dart';

import '../models/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.setupPageRoute}) : super(key: key);
  final String setupPageRoute;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Profile profile;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      listener: (context, state) {
        if (state is HomeBlocError) {
          RouteAction.goToReLogin(context, state.code, state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeBlocLoaded) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 55.0,
                            height: 55.0,
                            // color: Colors.green,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.green,
                              backgroundImage:
                                  NetworkImage("${profile.avatar?.trim()}"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${profile.firstName?.trim()}' +
                                    ' ' +
                                    '${profile.lastName?.trim()}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '${profile.email?.trim()}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is HomeBlocError) {
          RouteAction.goToReLogin(context, state.code, state.message);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
