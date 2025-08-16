import 'package:flutter/material.dart';


class MedioPagoScreen extends StatelessWidget {
  const MedioPagoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorPrincipal = Colors.pink[200];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrincipal,
        title: const Text('Medio de Pago'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: colorPrincipal!.withOpacity(0.08),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: colorPrincipal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(Icons.credit_card, color: colorPrincipal),
                title: const Text('Tarjeta de Crédito o Débito'),
                onTap: () {
                 
                },
              ),
            ),
          ),
          const Divider(height: 32),
          ListTile(
            leading: Icon(Icons.account_balance_wallet, color: colorPrincipal),
            title: const Text('PayPal'),
            onTap: () {
              
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.account_balance, color: colorPrincipal),
            title: const Text('Transferencia Bancaria'),
            onTap: () {
             
            },
          ),
        ],
      ),
    );
  }
}