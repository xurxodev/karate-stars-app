import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/default_stream_builder.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
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
    final appBloc = BlocProvider.of<AppBloc>(context);
    final purchasesBloc = BlocProvider.of<PurchasesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karate Stars Pro'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: _buildResults(appBloc, purchasesBloc),
    );
  }

  DefaultStateStreamBuilder<PurchasesStateData> _buildResults(
      AppBloc appBloc, PurchasesBloc purchasesBloc) {
    return DefaultStateStreamBuilder<PurchasesStateData>(
        initialData: purchasesBloc.state,
        stream: purchasesBloc.observableState,
        builder: (context, snapshot) {
          final purchasesState =
              (snapshot.data as LoadedState<PurchasesStateData>).data;

          return DefaultStateStreamBuilder<AppStateData>(
              initialData: appBloc.state,
              stream: appBloc.observableState,
              builder: (context, snapshot) {
                final isPremium =
                    (snapshot.data as LoadedState<AppStateData>).data.isPremium;

                return _buildProductList(
                    isPremium, purchasesState.products, purchasesBloc);
              });
        });
  }

  Card _buildProductList(
      bool isPremium, List<Product> products, PurchasesBloc bloc) {
    final content = isPremium
        ? [
            RoundedCard(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.blueGrey[50]
                    : Colors.grey[600],
                padding: const EdgeInsets.all(8.0),
                elevation: 0.0,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: const ListTile(
                    title: Text(
                      'Congrats!',
                    ),
                    subtitle: Text('You are Karate Stars PRO member')))
          ]
        : products.map(
            (Product product) {
              return RoundedCard(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.blueGrey[50]
                      : Colors.grey[600],
                  padding: const EdgeInsets.all(8.0),
                  elevation: 0.0,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: GestureDetector(
                      onTap: () {
                        bloc.purchase(product);
                      },
                      child: ListTile(
                        title: Text(
                          product.title,
                        ),
                        subtitle: Text(
                          product.description,
                        ),
                        trailing: TextButton(
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
                      )));
            },
          ).toList();

    return Card(
        child: Column(
            children: <Widget>[
                  Image.asset('assets/images/purchases-bg.png'),
                  const Divider()
                ] +
                content +
                _buildRestoreButton(isPremium, bloc)));
  }

  List<Widget> _buildRestoreButton(bool isPremium, PurchasesBloc bloc) {
    return isPremium ? []: [
      Padding(
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
      )
    ];
  }
}
