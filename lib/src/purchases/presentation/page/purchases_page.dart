import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/message.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/purchases/domain/product.dart';
import 'package:karate_stars_app/src/purchases/presentation/blocs/purchases_bloc.dart';
import 'package:karate_stars_app/src/purchases/presentation/state/purchases_state.dart';

class PurchasesPage extends StatefulWidget {
  static const routeName = '/purchases';

  static void navigate(BuildContext context) {
    Navigator.pushNamed(context, routeName);
  }

  static Widget create() {
    return BlocProvider(
        bloc: app_di.getIt<PurchasesBloc>(), child: PurchasesPage());
  }

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PurchasesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karate Stars Pro'),
      ),
      body: _buildResults(bloc),
    );
  }

  StreamBuilder<PurchasesState> _buildResults(PurchasesBloc bloc) {
    return StreamBuilder<PurchasesState>(
        initialData: bloc.state,
        stream: bloc.observableState,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state != null) {
            if (state is LoadingState) {
              return _buildLoading(state);
            } else if (state is ErrorState) {
              return _buildError(state);
            } else if (state is NotAvailableState) {
              return _buildNotAvailable(state);
            } else if (state is ProductsLoadedState) {
              return _buildProductList(state.products, bloc);
            } else {
              return Container();
            }
          } else {
            return const Text('No Data');
          }
        });
  }

  Widget _buildLoading(LoadingState state) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Progress(),
        const SizedBox(
          height: 16.0,
        ),
        Text(state.message)
      ],
    ));
  }

  Widget _buildError(ErrorState error) {
    return Center(
      child: Message(
        text: error.message,
        type: MessageType.error,
      ),
    );
  }

  Widget _buildNotAvailable(NotAvailableState state) {
    return const Message(
      text: Strings.purchase_store_store_is_not_available,
      type: MessageType.error,
    );
  }

  Card _buildProductList(List<Product> products, PurchasesBloc bloc) {
    final productList = products.map(
      (Product product) {
        return ListTile(
          title: Text(
            product.title,
          ),
          subtitle: Text(
            product.description,
          ),
          trailing:
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
                    // ignore: deprecated_member_use
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    bloc.purchase(product);
                  },
                  child: Text(product.formattedPrice),
                ),
        );
      },
    ).toList();

    return Card(
        child: Column(
            children: <Widget>[
                  const ListTile(title: Text('Products for Sale')),
                  const Divider()
                ] +
                productList + _buildRestoreButton(bloc)));
  }

 List<Widget> _buildRestoreButton(PurchasesBloc bloc) {

    return [Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              // ignore: deprecated_member_use
              primary: Colors.white,
            ),
            onPressed: () => bloc.restorePurchases(),
            child: const Text('Restore purchases'),
          ),
        ],
      ),
    )];
  }
}
