import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FS Generador',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(false),
      darkTheme: _buildTheme(true),
      home: SplashScreen(
        onToggleTheme: toggleTheme,
      ),
    );
  }

  ThemeData _buildTheme(bool isDark) {
    final surface = isDark ? const Color(0xFF080e1c) : const Color(0xFFF8FAFC);
    final onSurface = isDark ? const Color(0xFFe0e5f9) : const Color(0xFF0F172A);
    final primary = isDark ? const Color(0xFF85adff) : const Color(0xFF2563EB); 
    final secondary = isDark ? const Color(0xFF69f6b8) : const Color(0xFF059669); 

    final baseTextTheme = isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        onPrimary: const Color(0xFF002c66),
        secondary: secondary,
        onSecondary: const Color(0xFF005a3c),
        error: const Color(0xFFff716c),
        onError: const Color(0xFF490006),
        surface: surface,
        onSurface: onSurface,
      ),
      textTheme: GoogleFonts.manropeTextTheme(baseTextTheme).apply(
        bodyColor: onSurface,
        displayColor: onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
      ),
      useMaterial3: true,
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const SplashScreen({super.key, required this.onToggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GeneratorScreen(onToggleTheme: widget.onToggleTheme),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceContainerHighest = isDark ? const Color(0xFF1d2539) : const Color(0xFFe2e8f0);

    return Scaffold(
      body: Stack(
        children: [
          // Background ambient lights
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: primary.withOpacity(0.1), blurRadius: 100, spreadRadius: 50)
                ]
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: secondary.withOpacity(0.05),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: secondary.withOpacity(0.1), blurRadius: 100, spreadRadius: 50)
                ]
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Outer Ring
                      Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: surfaceContainerHighest.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20))
                            ]
                          ),
                        ),
                      ),
                      // Inner Brand Mark
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primary, primary.withOpacity(0.7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: primary.withOpacity(0.3), blurRadius: 40)
                          ]
                        ),
                        child: SvgPicture.asset(
                          'assets/JC.svg',
                          width: 45,
                          height: 45,
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Secondary Accent
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: secondary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 4),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)]
                          ),
                          child: Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.onSecondary, size: 20),
                        )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                // Tags
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.epilogue(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      letterSpacing: -1.0,
                    ),
                    children: [
                      const TextSpan(text: 'Fs'),
                      TextSpan(text: 'Gen', style: TextStyle(color: primary)),
                    ]
                  )
                ),
                const SizedBox(height: 8),
                Text(
                  'Generador de plantillas fs',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                  ),
                ),
                const SizedBox(height: 64),
                // Progress indicator (Simulated continuous)
                Container(
                  width: 180,
                  height: 4,
                  decoration: BoxDecoration(
                    color: surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      color: primary,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ),
                const SizedBox(height: 48),
                Text(
                  'BY JC EMILIANO V.1.0',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

class GeneratorScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const GeneratorScreen({super.key, required this.onToggleTheme});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  String? pastedText;
  String idc = 'JUAN CARLOS EMILIANO';
  DateTime selectedDate = DateTime.now();
  bool templatesGenerated = false;
  final TextEditingController _textController = TextEditingController();

  String folio = '';
  String cr = '';
  
  late SharedPreferences _prefs;
  bool _isLoading = true;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _loadDefaultIdc();
  }
  
  Future<void> _loadDefaultIdc() async {
    _prefs = await SharedPreferences.getInstance();
    final defaultIdc = _prefs.getString('default_idc');
    if (defaultIdc != null && defaultIdc.isNotEmpty) {
      setState(() {
        idc = defaultIdc;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _setDefaultIdc() async {
    await _prefs.setString('default_idc', idc);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$idc guardado como IDC por defecto.')),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null && data.text!.isNotEmpty) {
      setState(() {
        pastedText = data.text;
        _textController.text = data.text ?? '';
        templatesGenerated = false;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El portapapeles está vacío o no es texto.')),
        );
      }
    }
  }

  void _generateTemplates() {
    final texto = _textController.text;
    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pegue o escriba un texto primero para continuar.')),
      );
      return;
    }
    
    // Extraccion de datos con RegEx
    final folioMatch = RegExp(r'(INC\d+)').firstMatch(texto);
    final crMatch = RegExp(r'(\d{4}\s+[^*\r\n]+)').firstMatch(texto);

    if (folioMatch != null && crMatch != null) {
      setState(() {
        folio = folioMatch.group(1)!;
        cr = crMatch.group(1)!.trim().toUpperCase();
        templatesGenerated = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Plantillas generadas con éxito!')),
      );
    } else {
      setState(() {
        templatesGenerated = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡No se pudo extraer el FOLIO o CR, Edite el texto o pegue un texto válido!')),
      );
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              '$feature próximamente',
              style: GoogleFonts.manrope(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _getTemplate1() => '''FOLIO: $folio
CR: $cr
FECHA: $formattedDate
IDC: $idc 
ESTATUS: EN TRÁNSITO''';

  String _getTemplate2() => '''FOLIO: $folio
CR: $cr
FECHA: $formattedDate
IDC: $idc 
ESTATUS: CON ACCESO INTERVINIENDO EQUIPO  
EQUIPO: 
MARCA: 
MODELO: 
SERIE: 
SIAFF:
PUESTO:
HOSTNAME: 
MAC:
IP:
AREA:''';

  String _getTemplate3() => '''FOLIO: $folio
CR: $cr
FECHA: $formattedDate
FALLA: 
IDC: $idc 
DIAGNOSTICO: 
SOLUCION: 
SOPORTE PRYMENET:
SOPORTE WINDOWS: 
SOPORTE NACAR:

EQUIPO: 
MARCA:  
MODELO: 
SERIE: 
SIAFF:
PUESTO:
HOSTNAME:
MAC:
IP:
AREA: 
USUARIO:
VOBO: 
M:''';

  void _copyTemplate(String template, String name) {
    Clipboard.setData(ClipboardData(text: template));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Plantilla $name copiada al portapapeles.')),
    );
  }

  void _copyAllTemplates() {
    final allText = '${_getTemplate1()}\n\n---------------------------\n\n${_getTemplate2()}\n\n---------------------------\n\n${_getTemplate3()}';
    Clipboard.setData(ClipboardData(text: allText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Las 3 plantillas han sido copiadas al portapapeles.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final onSurfaceVariant = isDark ? const Color(0xFFa5abbd) : const Color(0xFF4f5565);
    final surfaceContainerLow = isDark ? const Color(0xFF0c1322) : const Color(0xFFFFFFFF);
    final surfaceContainerHighest = isDark ? const Color(0xFF1d2539) : const Color(0xFFe2e8f0);
    final outlineVariant = isDark ? const Color(0xFF424858) : const Color(0xFFCBD5E1);
    
    final primaryContainer = isDark ? const Color(0xFF6e9fff) : const Color(0xFFDBEAFE);
    final onPrimaryContainer = isDark ? const Color(0xFF002150) : const Color(0xFF1E3A8A);

    final glassCardColor = isDark 
        ? const Color(0xFF1d2539).withOpacity(0.65) 
        : const Color(0xFFFFFFFF).withOpacity(0.9);

    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final tertiary = isDark ? const Color(0xFFffe083) : const Color(0xFFD97706);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Presiona Atrás de nuevo para salir'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'FS GENERADOR',
            style: GoogleFonts.epilogue(
              color: primary,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, color: primary),
            onPressed: () => _showComingSoon('Menú'),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: primary,
              ),
              onPressed: widget.onToggleTheme,
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Stack(
              children: [
                // Main Scrollable Area
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Input Section: WhatsApp Paste Area
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: outlineVariant, width: 1.5),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: pastedText == null
                            ? GestureDetector(
                                onTap: _pasteFromClipboard,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 72,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        color: primaryContainer,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.content_paste, color: onPrimaryContainer, size: 32),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Pegar Folio aquí',
                                      style: TextStyle(
                                        color: onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: surfaceContainerHighest.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: outlineVariant.withOpacity(0.5)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 40, top: 8, bottom: 8),
                                          child: TextField(
                                            controller: _textController,
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            style: TextStyle(fontSize: 13, color: onSurfaceVariant, height: 1.5),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Edita tu folio aquí...',
                                              hintStyle: TextStyle(color: onSurfaceVariant.withOpacity(0.5)),
                                            ),
                                            onChanged: (val) {
                                              if (templatesGenerated) {
                                                setState(() => templatesGenerated = false);
                                              }
                                              if (val.isEmpty) {
                                                setState(() => pastedText = null);
                                              }
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(Icons.close, size: 16, color: Colors.redAccent),
                                              onPressed: () {
                                                _textController.clear();
                                                setState(() {
                                                  pastedText = null;
                                                  templatesGenerated = false;
                                                });
                                              },
                                              tooltip: 'Limpiar cuadro de texto',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: _generateTemplates,
                                    icon: const Icon(Icons.auto_awesome),
                                    label: const Text('Generar Plantillas'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primary,
                                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: 0,
                                    ),
                                  )
                                ],
                              ),
                      ),
                      const SizedBox(height: 32),
  
                      // Settings Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                                  child: Text(
                                    'INGENIERO DE CAMPO (IDC)',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: primary,
                                      letterSpacing: 1.2,
                                      
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _setDefaultIdc,
                                icon: Icon(Icons.save_alt, size: 14, color: primary),
                                label: Text('IDC Predeterminado', style: TextStyle(fontSize: 10, color: primary, fontWeight: FontWeight.bold)),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                  minimumSize: const Size(0, 24),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: surfaceContainerHighest.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: outlineVariant.withOpacity(0.3)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: idc,
                                isExpanded: true,
                                icon: Icon(Icons.expand_more, color: primary),
                                dropdownColor: surfaceContainerHighest,
                                items: ['JUAN CARLOS EMILIANO', 'OMAR GUDIÑO', 'GUADALUPE PÉREZ','ANDREA MARTÍNEZ','MIGUEL GUDIÑO','EDGAR GUDIÑO']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => idc = val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Fecha de Proceso',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: primary),
                            ),
                          ),
                          InkWell(
                            onTap: _selectDate,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: primary.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 14, color: primary),
                                  const SizedBox(width: 8),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
  
                      // Template Cards Area
                      Text(
                        'Plantillas Generadas',
                        style: GoogleFonts.epilogue(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 24),
  
                      // Card 1: INICIO
                      _TemplateCard(
                        title: 'PLANTILLA INICIO',
                        borderColor: primary,
                        statusText: 'En tránsito',
                        statusColor: primary,
                        bgColor: glassCardColor,
                        isDark: isDark,
                        onCopy: templatesGenerated ? () => _copyTemplate(_getTemplate1(), 'INICIO') : null,
                        children: [
                          _buildInfoRow([
                            _InfoItem('FOLIO', templatesGenerated ? folio : '---', isDark: isDark),
                            _InfoItem('CR', templatesGenerated ? cr : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('FECHA', templatesGenerated ? formattedDate : '---', isDark: isDark),
                            _InfoItem('IDC', idc, isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('ESTATUS', 'EN TRÁNSITO', fullWidth: true, isDark: isDark),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 24),
  
                      // Card 2: INTERVENCION
                      _TemplateCard(
                        title: 'PLANTILLA INTERVENCIÓN',
                        borderColor: tertiary,
                        statusText: 'Interviniendo',
                        statusColor: tertiary,
                        bgColor: glassCardColor,
                        isDark: isDark,
                        onCopy: templatesGenerated ? () => _copyTemplate(_getTemplate2(), 'INTERVENCIÓN') : null,
                        children: [
                          _buildInfoRow([
                            _InfoItem('FOLIO', templatesGenerated ? folio : '---', isDark: isDark),
                            _InfoItem('CR', templatesGenerated ? cr : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('FECHA', templatesGenerated ? formattedDate : '---', isDark: isDark),
                            _InfoItem('IDC', idc, isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('ESTATUS', 'CON ACCESO INTERVINIENDO EQUIPO', fullWidth: true, isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('EQUIPO', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('MARCA', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('MODELO', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('SERIE', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('SIAFF', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('PUESTO', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('HOSTNAME', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('MAC', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('IP', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('AREA', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 24),
  
                      // Card 3: CIERRE
                      _TemplateCard(
                        title: 'PLANTILLA CIERRE',
                        borderColor: secondary,
                        statusText: 'Finalizado',
                        statusColor: secondary,
                        bgColor: glassCardColor,
                        isDark: isDark,
                        onCopy: templatesGenerated ? () => _copyTemplate(_getTemplate3(), 'CIERRE') : null,
                        children: [
                          _buildInfoRow([
                            _InfoItem('FOLIO', templatesGenerated ? folio : '---', isDark: isDark),
                            _InfoItem('CR', templatesGenerated ? cr : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('FECHA', templatesGenerated ? formattedDate : '---', isDark: isDark),
                            _InfoItem('FALLA', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('IDC', idc, fullWidth: true, isDark: isDark),
                          ]),
                          // Diagnostico Box
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: surfaceContainerLow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: outlineVariant.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DIAGNOSTICO', style: TextStyle(color: onSurfaceVariant, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                                const SizedBox(height: 6),
                                Text(templatesGenerated ? '' : '---', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 11)),
                              ],
                            ),
                          ),
                          // Solucion Box
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: surfaceContainerLow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: outlineVariant.withOpacity(0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SOLUCION', style: TextStyle(color: onSurfaceVariant, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                                const SizedBox(height: 6),
                                Text(templatesGenerated ? '' : '---', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 11)),
                              ],
                            ),
                          ),
                          _buildInfoRow([
                            _InfoItem('SOPORTE PRYMENET', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('SOPORTE WINDOWS', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('SOPORTE NACAR', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('EQUIPO', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('MARCA', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('MODELO', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('SERIE', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('SIAFF', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('PUESTO', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('HOSTNAME', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('MAC', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('IP', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('AREA', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('USUARIO', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                          _buildInfoRow([
                            _InfoItem('VOBO', templatesGenerated ? '' : '---', isDark: isDark),
                            _InfoItem('M', templatesGenerated ? '' : '---', isDark: isDark),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action Button Wrapper
                if (templatesGenerated)
                  Positioned(
                    bottom: 40,
                    left: 24,
                    right: 24,
                    child: ElevatedButton(
                      onPressed: _copyAllTemplates,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 12,
                        shadowColor: primary.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.content_copy, size: 20),
                          SizedBox(width: 8),
                          Text('COPIAR 3 PLANTILLAS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1d2539).withOpacity(0.95) : const Color(0xFFffffff).withOpacity(0.95),
            border: Border(top: BorderSide(color: outlineVariant.withOpacity(0.3))),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 40,
                offset: const Offset(0, -10),
              )
            ],
          ),
          padding: const EdgeInsets.only(bottom: 24, top: 12, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: Icons.description, label: 'Plantillas', isActive: false, isDark: isDark,
                onTap: () => _showComingSoon('Plantillas'),
              ),
              _BottomNavItem(
                icon: Icons.dynamic_form, label: 'Generador', isActive: true, isDark: isDark,
                onTap: null, 
              ),
              _BottomNavItem(
                icon: Icons.settings, label: 'Configuración', isActive: false, isDark: isDark,
                onTap: () => _showComingSoon('Configuración'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String title;
  final Color borderColor;
  final String statusText;
  final Color statusColor;
  final Color bgColor;
  final bool isDark;
  final List<Widget> children;
  final VoidCallback? onCopy;

  const _TemplateCard({
    required this.title,
    required this.borderColor,
    required this.statusText,
    required this.statusColor,
    required this.bgColor,
    required this.isDark,
    required this.children,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: borderColor, width: 6)),
        boxShadow: [
          BoxShadow(color: isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: borderColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onCopy != null)
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: onCopy,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Icon(Icons.copy, size: 20, color: borderColor),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: borderColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText.toUpperCase(),
                      style: TextStyle(color: borderColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

Widget _buildInfoRow(List<Widget> items) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items,
  );
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool fullWidth;
  final bool isDark;

  const _InfoItem(this.label, this.value, {this.fullWidth = false, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant = isDark ? const Color(0xFFa5abbd) : const Color(0xFF64748b);
    
    Widget content = Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(color: onSurfaceVariant, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: onSurface, fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
    if (fullWidth) return content;
    return Expanded(child: content);
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = isActive 
        ? Theme.of(context).colorScheme.primary 
        : (isDark ? const Color(0xFFa5abbd) : const Color(0xFF64748b));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Theme.of(context).colorScheme.primary : c,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Theme.of(context).colorScheme.primary : c,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
