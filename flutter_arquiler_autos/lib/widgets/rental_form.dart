import 'package:flutter/material.dart';

class RentalForm extends StatefulWidget {
  final void Function(DateTime start, DateTime end, String paymentMethod)
  onSubmit;

  const RentalForm({super.key, required this.onSubmit});

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  DateTime? _start;
  DateTime? _end;
  String _payment = 'cash';

  Future<void> _pickDate(bool start) async {
    final now = DateTime.now();
    final initial = start
        ? (_start ?? now)
        : (_end ?? now.add(const Duration(days: 1)));
    final date = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDate: initial,
    );
    if (date != null) {
      setState(() {
        if (start) {
          _start = date;
          if (_end == null || _end!.isBefore(_start!)) {
            _end = _start!.add(const Duration(days: 1));
          }
        } else {
          _end = date;
          if (_start == null || _end!.isBefore(_start!)) {
            _start = _end!.subtract(const Duration(days: 1));
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _pickDate(true),
                child: Text(
                  _start == null
                      ? 'Fecha inicio'
                      : _start!.toString().split(' ').first,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _pickDate(false),
                child: Text(
                  _end == null
                      ? 'Fecha fin'
                      : _end!.toString().split(' ').first,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _payment,
          items: const [
            DropdownMenuItem(value: 'cash', child: Text('Efectivo')),
            DropdownMenuItem(value: 'card', child: Text('Tarjeta')),
            DropdownMenuItem(value: 'transfer', child: Text('Transferencia')),
          ],
          onChanged: (v) => setState(() => _payment = v ?? 'cash'),
          decoration: const InputDecoration(labelText: 'Medio de pago'),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: (_start == null || _end == null)
                ? null
                : () => widget.onSubmit(_start!, _end!, _payment),
            child: const Text('Confirmar arriendo'),
          ),
        ),
      ],
    );
  }
}
