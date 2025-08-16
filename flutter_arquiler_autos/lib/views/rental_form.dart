import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentalForm extends StatefulWidget {
  final double pricePerDay;
  final Function({
    required String name,
    required String email,
    required String phone,
    required String license,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
  })
  onSubmit;

  const RentalForm({
    super.key,
    required this.pricePerDay,
    required this.onSubmit,
  });

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  int get _rentalDays {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays + 1;
    }
    return 0;
  }

  double get _totalPrice => _rentalDays * widget.pricePerDay;

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue[400];
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datos personales',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Ingrese su nombre' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) =>
                  v == null || !v.contains('@') ? 'Correo inválido' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null || v.length < 7 ? 'Teléfono inválido' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _licenseController,
              decoration: const InputDecoration(
                labelText: 'Número de licencia',
                prefixIcon: Icon(Icons.credit_card),
              ),
              validator: (v) =>
                  v == null || v.length < 5 ? 'Licencia inválida' : null,
            ),
            const SizedBox(height: 20),
            Text(
              'Fechas de alquiler',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(isStart: true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Fecha inicio',
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      child: Text(
                        _startDate == null
                            ? 'Seleccionar'
                            : DateFormat('dd/MM/yyyy').format(_startDate!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: _startDate == null
                        ? null
                        : () => _pickDate(isStart: false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Fecha fin',
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      child: Text(
                        _endDate == null
                            ? 'Seleccionar'
                            : DateFormat('dd/MM/yyyy').format(_endDate!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_rentalDays > 0)
              Card(
                color: color!.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumen de alquiler',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Días de alquiler: $_rentalDays'),
                      Text(
                        'Precio por día: ${widget.pricePerDay.toStringAsFixed(2)}',
                      ),
                      Text(
                        'Precio total: ${_totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                label: const Text(
                  'Confirmar alquiler',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _startDate != null &&
                      _endDate != null) {
                    widget.onSubmit(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      license: _licenseController.text,
                      startDate: _startDate!,
                      endDate: _endDate!,
                      totalPrice: _totalPrice,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Completa todos los campos y fechas.'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
