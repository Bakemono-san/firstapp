import 'package:firstapp/src/Services/DependencyContainer.dart';

class Contextprovider {

  static dynamic _context = DependencyContainer.getDependency("provider");

  static dynamic getContext(){
    return _context;
  }
}


// ******** usage example ********

// Provider.of<Accounts>(context).getDataById(id);

// Consumer<Accounts>(
//   builder: (context, accountsProvider, child) {
//     return Column(
//       children: [
//         child!, // Won't rebuild when `accounts` changes
//         Text('Number of accounts: ${accountsProvider.accounts.length}'),
//       ],
//     );
//   },
//   child: Text('Static widget that doesn’t rebuild'),
// );