import express from 'express';
import bcrypt from 'bcryptjs';
import User from '../models/users.js';

const router = express.Router();

// Crear usuario (POST)
router.post('/agrege', async (req, res) => {
  try {
    const { nombre, email, password } = req.body;

    if (!nombre || !email || !password) {
      return res.status(400).json({ msg: 'Todos los campos son requeridos' });
    }

    // Verificar si el email ya está registrado
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(409).json({ msg: 'El email ya está registrado' });
    }

    // Encriptar contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ nombre, email, password: hashedPassword });

    await newUser.save();
    res.status(201).json({ msg: 'Usuario creado exitosamente' });
  } catch (error) {
    res.status(500).json({ msg: 'Error al crear usuario', error: error.message });
  }
});

// Obtener todos los usuarios (GET)
router.get('/liste', async (req, res) => {
  try {
    const users = await User.find().select("-password"); // excluye la contraseña
    res.json(users);
  } catch (error) {
    res.status(500).json({ msg: 'Error al obtener usuarios', error: error.message });
  }
});

// Obtener un usuario por ID (GET)
router.get('/liste/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select("-password");
    if (!user) return res.status(404).json({ msg: 'Usuario no encontrado' });
    res.json(user);
  } catch (error) {
    res.status(500).json({ msg: 'Error al obtener usuario', error: error.message });
  }
});

// Actualizar usuario (PUT)
router.put('/actualice/:id', async (req, res) => {
  try {
    const { password, ...rest } = req.body;
    let updatedData = rest;

    if (password) {
      updatedData.password = await bcrypt.hash(password, 10);
    }

    const updatedUser = await User.findByIdAndUpdate(req.params.id, updatedData, { new: true });
    res.json(updatedUser);
  } catch (error) {
    res.status(500).json({ msg: 'Error al actualizar usuario', error: error.message });
  }
});

// Eliminar usuario (DELETE)
router.delete('/elimine/:id', async (req, res) => {
  try {
    await User.findByIdAndDelete(req.params.id);
    res.json({ msg: 'Usuario eliminado' });
  } catch (error) {
    res.status(500).json({ msg: 'Error al eliminar usuario', error: error.message });
  }
});

router.post("/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Verificar que el correo no exista
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "El correo ya está registrado" });
    }

    // Encriptar contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = new User({
      name,
      email,
      password: hashedPassword,
    });

    await newUser.save();

    res.status(201).json({ message: "Usuario registrado con éxito" });
  } catch (error) {
    res.status(500).json({ message: "Error al registrar usuario", error });
  }
});

// Endpoint de login (POST)
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ msg: 'Email y password son requeridos' });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ msg: 'Credenciales inválidas' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ msg: 'Credenciales inválidas' });
    }

    res.status(200).json({
      msg: 'Login exitoso',
      user: {
        id: user._id,
        nombre: user.nombre,
        email: user.email,
      }
    });
  } catch (error) {
    res.status(500).json({ msg: 'Error en el login', error: error.message });
  }
});

export default router;
