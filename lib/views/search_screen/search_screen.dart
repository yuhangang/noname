import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:todonote/views/search_screen/channel_screens.dart';
import 'package:todonote/state/providers/local/search_provider.dart';
import 'package:todonote/widgets/icon_button.dart';

class SearchScreen extends StatelessWidget {
  static const String route = "/search_screen";
  FocusNode _focusNode = new FocusNode();
  final searchProvider =
      StateNotifierProvider.autoDispose<SearchProvider, SearchState>((ref) {
    return SearchProvider();
  });
  final TextEditingController _searchController = new TextEditingController();
  final _debouncer = Debouncer(delay: Duration(milliseconds: 0));

  void onSearchFieldChanged(String val, BuildContext context) {
    _debouncer.call(() => context.read(searchProvider.notifier).fetchData(val));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Future.delayed(Duration.zero, () => _focusNode.requestFocus());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        icon: Icons.arrow_back_ios,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                          child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: Theme.of(context).primaryColorDark)),
                        child: CupertinoSearchTextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          onChanged: (val) =>
                              onSearchFieldChanged(val, context),
                          itemSize: 25,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.8, 10, 5, 10),
                        ),
                      )),
                    ],
                  ),
                ),
                Expanded(child: ChannelScreen()),
              ],
            ),
            Consumer(
              builder: (context, watch, child) {
                return watch(searchProvider).status == SearchStatus.loading
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
