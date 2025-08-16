import 'package:flutter/material.dart';

class Menudrawerperfil extends StatefulWidget {
  @override
  State<Menudrawerperfil> createState() => _MenudrawerperfilState();
}

class _MenudrawerperfilState extends State<Menudrawerperfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
        backgroundColor: Color(0xFF60B5FF),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Avatar + Nombre + Correo
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/330/200',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Yesid Ortiz",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "yesid@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para editar perfil
                  },
                  icon: Icon(Icons.edit, size: 18),
                  label: Text("Editar Perfil"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF60B5FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 24),

          // Información del Usuario
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text("Teléfono"),
                    subtitle: Text("+57 300 123 4567"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.orange),
                    title: Text("Dirección"),
                    subtitle: Text("Calle 45 #12-34, Bogotá"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.credit_card, color: Colors.blue),
                    title: Text("Método de pago"),
                    subtitle: Text("Tarjeta Visa terminada en •••• 4589"),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Configuración rápida
          Text("Configuración",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock, color: Colors.redAccent),
                  title: Text("Cambiar Contraseña"),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.notifications, color: Colors.purple),
                  title: Text("Notificaciones"),
                  trailing: Switch(
                    value: true,
                    onChanged: (val) {},
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help, color: Colors.teal),
                  title: Text("Ayuda y soporte"),
                  onTap: () {},
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Historial de alquileres
          Text("Historial de Alquileres",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.directions_car, color: Color(0xFF60B5FF)),
                  title: Text("Chevrolet Spark 2022"),
                  subtitle: Text("Finalizó: 12 Ago 2025"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.directions_car, color: Color(0xFFFF9149)),
                  title: Text("Toyota Corolla 2023"),
                  subtitle: Text("Finalizó: 3 Jul 2025"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
