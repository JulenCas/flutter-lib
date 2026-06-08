/// Catálogo reutilizable de widgets Flutter agrupado por escenarios comunes.
///
/// La librería no crea dependencias con Material ni Cupertino porque sus
/// ejemplos viven como cadenas de documentación. Esto permite importar el
/// catálogo desde herramientas internas, documentación, tests o pantallas de
/// ayuda sin forzar dependencias visuales concretas.
///
/// Cada entrada resume:
/// - propósito del widget;
/// - cuándo elegirlo por usabilidad y rendimiento;
/// - propiedades relevantes comentadas;
/// - variantes importantes;
/// - un ejemplo de uso listo para copiar en una app Flutter.
library flutter_widget_catalog;

/// Categorías usadas para organizar el catálogo.
enum FlutterWidgetCategory {
  /// Widgets de composición básica y contenido simple.
  basic,

  /// Widgets para distribuir espacio, alinear y construir listas o grillas.
  layout,

  /// Componentes visuales de Material Design.
  material,

  /// Componentes visuales de Cupertino/iOS.
  cupertino,

  /// Controles para entrada, selección y formularios.
  input,

  /// Widgets de animación implícita, compartida y basada en assets.
  animation,

  /// Widgets y APIs para navegación y organización de páginas.
  navigation,

  /// Widgets para representar datos asíncronos.
  asynchrony,

  /// Widgets avanzados y utilidades de interacción.
  utilities,
}

/// Etiquetas legibles en español para pintar las categorías en UI.
extension FlutterWidgetCategoryLabel on FlutterWidgetCategory {
  /// Nombre corto de la categoría.
  String get label => switch (this) {
        FlutterWidgetCategory.basic => 'Básicos',
        FlutterWidgetCategory.layout => 'Layout',
        FlutterWidgetCategory.material => 'Material',
        FlutterWidgetCategory.cupertino => 'Cupertino',
        FlutterWidgetCategory.input => 'Controles de entrada',
        FlutterWidgetCategory.animation => 'Animaciones',
        FlutterWidgetCategory.navigation => 'Navegación',
        FlutterWidgetCategory.asynchrony => 'Asincronía',
        FlutterWidgetCategory.utilities => 'Utilidades avanzadas',
      };

  /// Descripción orientada a decidir qué familia consultar.
  String get description => switch (this) {
        FlutterWidgetCategory.basic => 'Contenido esencial como texto, imágenes e iconos.',
        FlutterWidgetCategory.layout => 'Distribución, alineación, listas y grillas.',
        FlutterWidgetCategory.material => 'Componentes Material Design para Android y web.',
        FlutterWidgetCategory.cupertino => 'Componentes con comportamiento y estética iOS.',
        FlutterWidgetCategory.input => 'Campos, botones y selectores para capturar datos.',
        FlutterWidgetCategory.animation => 'Transiciones y feedback visual animado.',
        FlutterWidgetCategory.navigation => 'Rutas, páginas y pestañas.',
        FlutterWidgetCategory.asynchrony => 'Estados de carga, error y datos en Future o Stream.',
        FlutterWidgetCategory.utilities => 'Patrones avanzados de scroll, drag, reorder y expansión.',
      };
}

/// Nota breve sobre una propiedad importante de un widget.
class WidgetPropertyNote {
  /// Nombre exacto o habitual de la propiedad.
  final String name;

  /// Explicación de cuándo y cómo usarla.
  final String comment;

  /// Crea una nota de propiedad.
  const WidgetPropertyNote({
    required this.name,
    required this.comment,
  });
}

/// Variante destacada de un widget o patrón equivalente.
class WidgetVariantNote {
  /// Nombre de la variante, constructor o widget relacionado.
  final String name;

  /// Diferencia práctica frente a la entrada principal.
  final String comment;

  /// Crea una nota de variante.
  const WidgetVariantNote({
    required this.name,
    required this.comment,
  });
}

/// Entrada documental para un widget reutilizable o patrón Flutter.
class FlutterWidgetCatalogEntry {
  /// Categoría funcional de la entrada.
  final FlutterWidgetCategory category;

  /// Nombre del widget, constructor o API.
  final String name;

  /// Propósito principal en una frase.
  final String purpose;

  /// Recomendación de elección centrada en UX y rendimiento.
  final String whenToUse;

  /// Propiedades relevantes con comentarios prácticos.
  final List<WidgetPropertyNote> properties;

  /// Variantes o alternativas importantes.
  final List<WidgetVariantNote> variants;

  /// Ejemplo Dart/Flutter listo para copiar.
  final String example;

  /// Crea una entrada del catálogo.
  const FlutterWidgetCatalogEntry({
    required this.category,
    required this.name,
    required this.purpose,
    required this.whenToUse,
    required this.properties,
    this.variants = const [],
    required this.example,
  });
}

/// Catálogo completo de widgets Flutter para escenarios comunes.
///
/// Usa [widgetCatalogByCategory] cuando necesites pintar menús por categoría.
const List<FlutterWidgetCatalogEntry> flutterWidgetCatalog = [
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.basic,
    name: 'Text',
    purpose: 'Muestra texto estático o dinámico con estilo, overflow y alineación.',
    whenToUse:
        'Elige Text para etiquetas, títulos y contenido corto; usa RichText cuando varias partes del mismo párrafo necesiten estilos o gestos diferentes.',
    properties: [
      WidgetPropertyNote(name: 'data', comment: 'Cadena visible; evita concatenar textos traducibles y prefiere interpolación/localización.'),
      WidgetPropertyNote(name: 'style', comment: 'Define fuente, tamaño, peso y color; usa Theme.of(context).textTheme para consistencia.'),
      WidgetPropertyNote(name: 'maxLines', comment: 'Limita líneas para tarjetas/listas y evita que un texto rompa el layout.'),
      WidgetPropertyNote(name: 'overflow', comment: 'Usa TextOverflow.ellipsis en listas para mejorar legibilidad cuando no hay espacio.'),
      WidgetPropertyNote(name: 'textAlign', comment: 'Alinea contenido dentro del ancho disponible; no reemplaza la alineación del padre.'),
    ],
    variants: [
      WidgetVariantNote(name: 'RichText', comment: 'Permite spans con estilos mixtos y reconocedores de gestos.'),
      WidgetVariantNote(name: 'SelectableText', comment: 'Útil para correos, códigos o contenido que el usuario debe copiar.'),
    ],
    example: r'''
Text(
  'Hola Flutter',
  maxLines: 1, // Evita saltos inesperados en una fila o tarjeta.
  overflow: TextOverflow.ellipsis, // Muestra "..." si no cabe.
  style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.basic,
    name: 'Image',
    purpose: 'Renderiza imágenes desde assets, red, memoria o archivo.',
    whenToUse:
        'Usa assets para iconografía estable y network para contenido remoto; define dimensiones para reducir saltos de layout y considera cache/placeholder en listas.',
    properties: [
      WidgetPropertyNote(name: 'asset/network/file/memory', comment: 'Constructor según origen; Image.network conviene para contenido remoto no empaquetado.'),
      WidgetPropertyNote(name: 'width/height', comment: 'Reservan espacio y evitan cambios visuales durante carga.'),
      WidgetPropertyNote(name: 'fit', comment: 'BoxFit.cover recorta para llenar; contain conserva imagen completa.'),
      WidgetPropertyNote(name: 'semanticLabel', comment: 'Describe imágenes relevantes para accesibilidad.'),
      WidgetPropertyNote(name: 'loadingBuilder/errorBuilder', comment: 'Mejoran UX en red mostrando progreso o fallback.'),
    ],
    example: r'''
Image.network(
  avatarUrl,
  width: 64,
  height: 64,
  fit: BoxFit.cover, // Recorta manteniendo proporción.
  semanticLabel: 'Foto de perfil',
  errorBuilder: (_, __, ___) => const Icon(Icons.person),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.basic,
    name: 'Icon',
    purpose: 'Muestra símbolos vectoriales de Material Icons u otras fuentes de iconos.',
    whenToUse:
        'Ideal para acciones reconocibles; acompáñalo con texto o tooltip cuando el significado no sea universal.',
    properties: [
      WidgetPropertyNote(name: 'icon', comment: 'IconData a renderizar, por ejemplo Icons.search.'),
      WidgetPropertyNote(name: 'size', comment: 'Controla tamaño visual; 24 es estándar Material.'),
      WidgetPropertyNote(name: 'color', comment: 'Usa colores del Theme para estados activo/inactivo.'),
      WidgetPropertyNote(name: 'semanticLabel', comment: 'Texto para lectores de pantalla cuando el icono aporta información.'),
    ],
    example: r'''
const Icon(
  Icons.search,
  size: 24,
  color: Colors.blue,
  semanticLabel: 'Buscar',
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.layout,
    name: 'Container',
    purpose: 'Agrupa decoración, espaciado, tamaño, alineación y un único hijo.',
    whenToUse:
        'Úsalo como caja flexible para prototipos y tarjetas simples; para máximo rendimiento prefiere widgets específicos como Padding, SizedBox o DecoratedBox si solo necesitas una responsabilidad.',
    properties: [
      WidgetPropertyNote(name: 'padding', comment: 'Espacio interno entre borde y child; mejora legibilidad y área táctil.'),
      WidgetPropertyNote(name: 'margin', comment: 'Espacio externo frente a widgets vecinos; no afecta el tamaño del child.'),
      WidgetPropertyNote(name: 'color', comment: 'Color de fondo rápido; no se puede combinar con decoration.color.'),
      WidgetPropertyNote(name: 'decoration', comment: 'Bordes, radios, sombras o gradientes; usa BoxDecoration para tarjetas personalizadas.'),
      WidgetPropertyNote(name: 'width/height', comment: 'Fijan dimensiones; evita valores rígidos si la UI debe adaptarse.'),
      WidgetPropertyNote(name: 'alignment', comment: 'Posiciona el child dentro del espacio disponible.'),
    ],
    variants: [
      WidgetVariantNote(name: 'Padding', comment: 'Más eficiente y claro cuando solo necesitas padding.'),
      WidgetVariantNote(name: 'SizedBox', comment: 'Preferible para espacios o tamaños fijos.'),
      WidgetVariantNote(name: 'DecoratedBox', comment: 'Ligero cuando solo necesitas decoración.'),
    ],
    example: r'''
Container(
  margin: const EdgeInsets.all(16), // Separación externa.
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Espacio interno.
  decoration: BoxDecoration(
    color: Colors.white, // Fondo de la tarjeta.
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
  ),
  child: const Text('Contenido destacado'),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.layout,
    name: 'Row / Column',
    purpose: 'Distribuyen hijos en horizontal (Row) o vertical (Column).',
    whenToUse:
        'Usa Row para barras y acciones en línea, Column para formularios o secciones apiladas; evita listas largas dentro de Column sin scroll.',
    properties: [
      WidgetPropertyNote(name: 'children', comment: 'Lista de widgets; mantenla pequeña o usa ListView para colecciones grandes.'),
      WidgetPropertyNote(name: 'mainAxisAlignment', comment: 'Distribuye en el eje principal: horizontal en Row, vertical en Column.'),
      WidgetPropertyNote(name: 'crossAxisAlignment', comment: 'Alinea en el eje perpendicular.'),
      WidgetPropertyNote(name: 'spacing', comment: 'En SDKs recientes separa hijos sin SizedBox repetidos; si no está disponible, usa SizedBox.'),
      WidgetPropertyNote(name: 'Expanded/Flexible', comment: 'Controlan cómo un hijo ocupa espacio restante y evitan overflow.'),
    ],
    variants: [
      WidgetVariantNote(name: 'Row', comment: 'Para layout horizontal; combina con Expanded si un texto puede crecer.'),
      WidgetVariantNote(name: 'Column', comment: 'Para layout vertical; combina con SingleChildScrollView si el contenido puede exceder la pantalla.'),
      WidgetVariantNote(name: 'Wrap', comment: 'Cuando los elementos deben saltar de línea en pantallas estrechas.'),
    ],
    example: r'''
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    const Icon(Icons.info),
    const SizedBox(width: 8),
    Expanded(child: Text(title)), // Evita overflow en textos largos.
    TextButton(onPressed: onTap, child: const Text('Ver')),
  ],
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.layout,
    name: 'Stack / Positioned',
    purpose: 'Superpone widgets en capas y posiciona elementos sobre un área.',
    whenToUse:
        'Úsalo para badges, overlays, héroes visuales y fondos; evita usarlo como solución general de layout porque reduce adaptabilidad.',
    properties: [
      WidgetPropertyNote(name: 'children', comment: 'El orden importa: los últimos se pintan encima.'),
      WidgetPropertyNote(name: 'alignment', comment: 'Ubicación por defecto de hijos no posicionados.'),
      WidgetPropertyNote(name: 'fit', comment: 'StackFit.expand fuerza hijos no posicionados a ocupar todo el espacio.'),
      WidgetPropertyNote(name: 'clipBehavior', comment: 'Controla si se recorta contenido fuera del stack.'),
      WidgetPropertyNote(name: 'Positioned', comment: 'Define top/right/bottom/left/width/height para un hijo específico.'),
    ],
    example: r'''
Stack(
  children: [
    Image.network(photoUrl, fit: BoxFit.cover),
    Positioned(
      right: 8,
      top: 8,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
        child: const Padding(padding: EdgeInsets.all(6), child: Text('NEW')),
      ),
    ),
  ],
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.layout,
    name: 'ListView',
    purpose: 'Muestra una lista desplazable vertical u horizontal.',
    whenToUse:
        'Usa ListView.builder para listas grandes o remotas porque crea filas bajo demanda; ListView.separated agrega divisores sin inflar el modelo de datos.',
    properties: [
      WidgetPropertyNote(name: 'children', comment: 'Adecuado solo para listas cortas y estáticas porque construye todo de inmediato.'),
      WidgetPropertyNote(name: 'itemBuilder', comment: 'Construye celdas de forma perezosa; ideal para rendimiento en colecciones grandes.'),
      WidgetPropertyNote(name: 'separatorBuilder', comment: 'En separated crea separadores independientes sin mezclarlos con los datos.'),
      WidgetPropertyNote(name: 'itemCount', comment: 'Evita builders infinitos accidentalmente y permite calcular scroll correctamente.'),
      WidgetPropertyNote(name: 'shrinkWrap', comment: 'Úsalo con cuidado dentro de otro scroll; puede ser costoso porque mide todo.'),
      WidgetPropertyNote(name: 'cacheExtent', comment: 'Precarga contenido cercano; aumenta fluidez a costa de memoria.'),
    ],
    variants: [
      WidgetVariantNote(name: 'ListView.builder', comment: 'Mejor opción para listas grandes, paginadas o dinámicas.'),
      WidgetVariantNote(name: 'ListView.separated', comment: 'Útil cuando cada fila necesita un divisor o espacio uniforme.'),
      WidgetVariantNote(name: 'SliverList', comment: 'Preferible dentro de CustomScrollView con headers, grids o app bars colapsables.'),
    ],
    example: r'''
ListView.separated(
  itemCount: users.length,
  itemBuilder: (context, index) => ListTile(
    title: Text(users[index].name),
    subtitle: Text(users[index].email),
  ),
  separatorBuilder: (_, __) => const Divider(height: 1),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.layout,
    name: 'GridView',
    purpose: 'Organiza elementos en una grilla desplazable.',
    whenToUse:
        'Usa GridView.count para grillas pequeñas con columnas fijas; GridView.builder para catálogos grandes o infinitos por creación perezosa.',
    properties: [
      WidgetPropertyNote(name: 'crossAxisCount', comment: 'Número de columnas en GridView.count; adapta con breakpoints para responsive.'),
      WidgetPropertyNote(name: 'gridDelegate', comment: 'Controla columnas, tamaños, spacing y proporción de celdas.'),
      WidgetPropertyNote(name: 'mainAxisSpacing/crossAxisSpacing', comment: 'Separación vertical/horizontal entre celdas.'),
      WidgetPropertyNote(name: 'childAspectRatio', comment: 'Relación ancho/alto para evitar celdas deformadas.'),
      WidgetPropertyNote(name: 'itemBuilder', comment: 'En builder crea celdas solo cuando son visibles.'),
    ],
    variants: [
      WidgetVariantNote(name: 'GridView.count', comment: 'Sintaxis simple para pocas celdas conocidas.'),
      WidgetVariantNote(name: 'GridView.builder', comment: 'Escalable para catálogos, fotos y resultados paginados.'),
      WidgetVariantNote(name: 'SliverGrid', comment: 'Para combinar grillas con otros slivers en un solo scroll.'),
    ],
    example: r'''
GridView.builder(
  itemCount: products.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 0.75,
  ),
  itemBuilder: (_, index) => ProductCard(product: products[index]),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.material,
    name: 'Scaffold',
    purpose: 'Estructura base de una pantalla Material con app bar, body, drawer, FAB y navegación inferior.',
    whenToUse:
        'Úsalo como contenedor de cada pantalla Material; mantiene áreas seguras y patrones consistentes de navegación y acciones.',
    properties: [
      WidgetPropertyNote(name: 'appBar', comment: 'Barra superior con título y acciones.'),
      WidgetPropertyNote(name: 'body', comment: 'Contenido principal; normalmente incluye scroll cuando el contenido puede crecer.'),
      WidgetPropertyNote(name: 'floatingActionButton', comment: 'Acción primaria de la pantalla; evita múltiples FAB compitiendo.'),
      WidgetPropertyNote(name: 'bottomNavigationBar', comment: 'Navegación entre secciones principales persistentes.'),
      WidgetPropertyNote(name: 'drawer/endDrawer', comment: 'Menú lateral para navegación secundaria o filtros.'),
    ],
    example: r'''
Scaffold(
  appBar: AppBar(title: const Text('Inicio')),
  drawer: const AppDrawer(),
  body: const Center(child: Text('Contenido')),
  floatingActionButton: FloatingActionButton(
    onPressed: createItem,
    child: const Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
  ]),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.material,
    name: 'AppBar / TabBar',
    purpose: 'Muestra título, acciones y pestañas Material en la parte superior.',
    whenToUse:
        'AppBar funciona para jerarquía y acciones globales; añade TabBar cuando la pantalla divide contenido hermano al mismo nivel.',
    properties: [
      WidgetPropertyNote(name: 'title', comment: 'Identifica la pantalla; debe ser corto y localizable.'),
      WidgetPropertyNote(name: 'actions', comment: 'Acciones secundarias; agrupa exceso en PopupMenuButton.'),
      WidgetPropertyNote(name: 'bottom', comment: 'Ubicación habitual de TabBar dentro de AppBar.'),
      WidgetPropertyNote(name: 'tabs', comment: 'Lista de pestañas; mantén etiquetas breves o usa iconos con semántica.'),
      WidgetPropertyNote(name: 'controller', comment: 'Sincroniza TabBar con TabBarView si no usas DefaultTabController.'),
    ],
    variants: [
      WidgetVariantNote(name: 'SliverAppBar', comment: 'Se colapsa/expande dentro de CustomScrollView para pantallas ricas.'),
      WidgetVariantNote(name: 'CupertinoNavigationBar', comment: 'Alternativa visual para experiencias iOS.'),
    ],
    example: r'''
DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      title: const Text('Reportes'),
      actions: [IconButton(onPressed: refresh, icon: const Icon(Icons.refresh))],
      bottom: const TabBar(tabs: [Tab(text: 'Hoy'), Tab(text: 'Mes')]),
    ),
    body: const TabBarView(children: [TodayReport(), MonthReport()]),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.material,
    name: 'BottomNavigationBar',
    purpose: 'Permite cambiar entre destinos principales de una app Material.',
    whenToUse:
        'Elígelo para 3 a 5 secciones de primer nivel; preserva estado con IndexedStack si cada pestaña mantiene scroll o formularios.',
    properties: [
      WidgetPropertyNote(name: 'items', comment: 'Destinos con icono y etiqueta; etiquetas claras mejoran accesibilidad.'),
      WidgetPropertyNote(name: 'currentIndex', comment: 'Índice activo controlado por el estado de la pantalla.'),
      WidgetPropertyNote(name: 'onTap', comment: 'Actualiza el destino sin recrear innecesariamente toda la app.'),
      WidgetPropertyNote(name: 'type', comment: 'Fixed para pocas pestañas; shifting enfatiza selección con más destinos.'),
    ],
    variants: [
      WidgetVariantNote(name: 'NavigationBar', comment: 'Componente Material 3 recomendado en apps nuevas.'),
      WidgetVariantNote(name: 'CupertinoTabBar', comment: 'Equivalente para estilo iOS.'),
    ],
    example: r'''
BottomNavigationBar(
  currentIndex: index,
  onTap: setIndex,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
  ],
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.material,
    name: 'Drawer',
    purpose: 'Panel lateral para navegación secundaria, cuenta o configuración.',
    whenToUse:
        'Úsalo cuando hay más destinos de los que caben en navegación inferior; evita ocultar acciones críticas dentro del drawer.',
    properties: [
      WidgetPropertyNote(name: 'child', comment: 'Normalmente un ListView con DrawerHeader y ListTile.'),
      WidgetPropertyNote(name: 'DrawerHeader', comment: 'Muestra identidad de app o usuario.'),
      WidgetPropertyNote(name: 'ListTile.onTap', comment: 'Cierra el drawer y navega; evita dejarlo abierto sobre la pantalla destino.'),
    ],
    example: r'''
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(child: Text('Mi app')),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Ajustes'),
        onTap: () => Navigator.pushNamed(context, '/settings'),
      ),
    ],
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.material,
    name: 'Card',
    purpose: 'Agrupa contenido relacionado con elevación, forma y superficie Material.',
    whenToUse:
        'Úsala para ítems independientes en feeds o resúmenes; no abuses de sombras en listas densas por ruido visual y coste de pintura.',
    properties: [
      WidgetPropertyNote(name: 'elevation', comment: 'Profundidad visual; valores altos pueden distraer.'),
      WidgetPropertyNote(name: 'shape', comment: 'Bordes y radios; alinea con el sistema de diseño.'),
      WidgetPropertyNote(name: 'margin', comment: 'Separación externa entre tarjetas.'),
      WidgetPropertyNote(name: 'child', comment: 'Contenido; combina con ListTile, Padding o Column.'),
    ],
    example: r'''
Card(
  margin: const EdgeInsets.all(12),
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  child: ListTile(
    leading: const Icon(Icons.article),
    title: Text(article.title),
    subtitle: Text(article.summary),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.cupertino,
    name: 'CupertinoPageScaffold / CupertinoNavigationBar',
    purpose: 'Estructura una pantalla con estética iOS y barra de navegación nativa.',
    whenToUse:
        'Elígelo en apps iOS-first o pantallas que deban sentirse nativas; no mezcles patrones Material y Cupertino sin intención clara.',
    properties: [
      WidgetPropertyNote(name: 'navigationBar', comment: 'Barra superior iOS con middle, leading y trailing.'),
      WidgetPropertyNote(name: 'child', comment: 'Contenido principal; envuélvelo en SafeArea si necesitas controlar insets.'),
      WidgetPropertyNote(name: 'backgroundColor', comment: 'Superficie de pantalla; usa CupertinoColors.systemBackground para modo oscuro.'),
    ],
    example: r'''
CupertinoPageScaffold(
  navigationBar: const CupertinoNavigationBar(
    middle: Text('Perfil'),
  ),
  child: SafeArea(
    child: CupertinoButton.filled(
      onPressed: save,
      child: const Text('Guardar'),
    ),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.cupertino,
    name: 'CupertinoTabScaffold / CupertinoTabBar',
    purpose: 'Navegación inferior iOS con stacks independientes por pestaña.',
    whenToUse:
        'Úsalo para apps iOS con secciones principales; conserva navegación por pestaña de forma más natural que un único Navigator global.',
    properties: [
      WidgetPropertyNote(name: 'tabBar', comment: 'Define destinos con BottomNavigationBarItem.'),
      WidgetPropertyNote(name: 'tabBuilder', comment: 'Construye el contenido de cada pestaña bajo demanda.'),
      WidgetPropertyNote(name: 'CupertinoTabView', comment: 'Da un Navigator independiente por pestaña.'),
    ],
    example: r'''
CupertinoTabScaffold(
  tabBar: CupertinoTabBar(items: const [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Perfil'),
  ]),
  tabBuilder: (_, index) => CupertinoTabView(
    builder: (_) => index == 0 ? const HomePage() : const ProfilePage(),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.cupertino,
    name: 'CupertinoFormSection / CupertinoTextFormFieldRow',
    purpose: 'Agrupa campos con apariencia de formulario iOS.',
    whenToUse:
        'Útil en ajustes y formularios iOS; mantiene densidad, separadores y etiquetas familiares para usuarios de iPhone.',
    properties: [
      WidgetPropertyNote(name: 'header/footer', comment: 'Explican el grupo o restricciones del formulario.'),
      WidgetPropertyNote(name: 'prefix', comment: 'Etiqueta alineada a la izquierda del campo.'),
      WidgetPropertyNote(name: 'placeholder', comment: 'Ayuda breve, no reemplaza una etiqueta accesible.'),
      WidgetPropertyNote(name: 'keyboardType', comment: 'Muestra teclado adecuado para email, número o teléfono.'),
    ],
    example: r'''
CupertinoFormSection.insetGrouped(
  header: const Text('Cuenta'),
  children: [
    CupertinoTextFormFieldRow(
      prefix: const Text('Email'),
      placeholder: 'nombre@dominio.com',
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
    ),
  ],
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.input,
    name: 'TextField / TextFormField',
    purpose: 'Captura texto libre con teclado, validación y formato.',
    whenToUse:
        'Usa TextField para entradas simples y TextFormField dentro de Form cuando necesitas validación, submit y errores coordinados.',
    properties: [
      WidgetPropertyNote(name: 'controller', comment: 'Lee o actualiza el valor; libera el controller en dispose.'),
      WidgetPropertyNote(name: 'decoration', comment: 'Label, hint, iconos y texto de error; mejora comprensión del campo.'),
      WidgetPropertyNote(name: 'keyboardType', comment: 'Optimiza teclado según dato esperado.'),
      WidgetPropertyNote(name: 'obscureText', comment: 'Oculta contraseñas; añade botón para mostrar/ocultar si aporta UX.'),
      WidgetPropertyNote(name: 'validator', comment: 'En TextFormField devuelve mensaje de error o null.'),
      WidgetPropertyNote(name: 'inputFormatters', comment: 'Limita longitud o formato antes de actualizar estado.'),
    ],
    example: r'''
TextFormField(
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
    labelText: 'Correo',
    hintText: 'nombre@dominio.com',
    prefixIcon: Icon(Icons.email),
  ),
  validator: (value) => value != null && value.contains('@') ? null : 'Correo inválido',
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.input,
    name: 'Button widgets',
    purpose: 'Ejecutan acciones mediante ElevatedButton, FilledButton, OutlinedButton, TextButton o IconButton.',
    whenToUse:
        'Usa un botón prominente para la acción primaria, outlined/text para secundarias e IconButton solo si el icono es inequívoco o tiene tooltip.',
    properties: [
      WidgetPropertyNote(name: 'onPressed', comment: 'null deshabilita el botón; ideal mientras validas o cargas.'),
      WidgetPropertyNote(name: 'child', comment: 'Texto o contenido visual; debe comunicar la acción.'),
      WidgetPropertyNote(name: 'style', comment: 'Personaliza color, padding, shape y estados usando ButtonStyle.'),
      WidgetPropertyNote(name: 'tooltip', comment: 'En IconButton aclara significado y ayuda accesibilidad.'),
    ],
    variants: [
      WidgetVariantNote(name: 'ElevatedButton/FilledButton', comment: 'Acción primaria de alto énfasis.'),
      WidgetVariantNote(name: 'OutlinedButton', comment: 'Acción secundaria con borde.'),
      WidgetVariantNote(name: 'TextButton', comment: 'Acciones de bajo énfasis, diálogos o barras.'),
    ],
    example: r'''
ElevatedButton.icon(
  onPressed: isValid ? submit : null, // null lo deshabilita.
  icon: const Icon(Icons.save),
  label: const Text('Guardar'),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.input,
    name: 'Checkbox / Switch / Radio / Slider',
    purpose: 'Permiten selección booleana, exclusiva o de rango.',
    whenToUse:
        'Checkbox para múltiples opciones, Switch para activar algo inmediato, Radio para una opción excluyente y Slider para valores continuos con feedback visual.',
    properties: [
      WidgetPropertyNote(name: 'value', comment: 'Estado actual controlado por la pantalla.'),
      WidgetPropertyNote(name: 'onChanged', comment: 'Actualiza el estado; null deshabilita el control.'),
      WidgetPropertyNote(name: 'min/max/divisions', comment: 'En Slider definen rango y saltos.'),
      WidgetPropertyNote(name: 'groupValue', comment: 'En Radio identifica la opción seleccionada del grupo.'),
      WidgetPropertyNote(name: 'label/semantics', comment: 'Acompaña controles con texto para accesibilidad y claridad.'),
    ],
    example: r'''
SwitchListTile(
  title: const Text('Notificaciones'),
  subtitle: const Text('Recibir alertas importantes'),
  value: notificationsEnabled,
  onChanged: setNotificationsEnabled,
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.animation,
    name: 'AnimatedContainer',
    purpose: 'Anima automáticamente cambios de tamaño, color, margen, padding y decoración.',
    whenToUse:
        'Elígelo para microinteracciones simples sin manejar AnimationController; si necesitas coordinación compleja usa animaciones explícitas.',
    properties: [
      WidgetPropertyNote(name: 'duration', comment: 'Tiempo de transición; 150-300 ms suele sentirse ágil.'),
      WidgetPropertyNote(name: 'curve', comment: 'Define aceleración; easeInOut es natural para cambios de estado.'),
      WidgetPropertyNote(name: 'width/height/color/decoration', comment: 'Propiedades animables cuando cambian entre builds.'),
      WidgetPropertyNote(name: 'onEnd', comment: 'Callback al finalizar; evita encadenar demasiada lógica visual.'),
    ],
    example: r'''
AnimatedContainer(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeInOut,
  width: expanded ? 240 : 120,
  height: 80,
  decoration: BoxDecoration(
    color: expanded ? Colors.blue : Colors.grey,
    borderRadius: BorderRadius.circular(expanded ? 24 : 8),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.animation,
    name: 'AnimatedOpacity',
    purpose: 'Anima la opacidad de un hijo al aparecer o desaparecer.',
    whenToUse:
        'Úsalo para feedback suave; recuerda que un widget invisible puede seguir ocupando espacio y recibir interacción si no lo combinas con IgnorePointer.',
    properties: [
      WidgetPropertyNote(name: 'opacity', comment: 'Valor de 0 a 1; 0 invisible, 1 opaco.'),
      WidgetPropertyNote(name: 'duration', comment: 'Duración de fade.'),
      WidgetPropertyNote(name: 'curve', comment: 'Curva temporal de la transición.'),
      WidgetPropertyNote(name: 'child', comment: 'Contenido que se desvanece; sigue en el árbol durante la animación.'),
    ],
    example: r'''
IgnorePointer(
  ignoring: !visible,
  child: AnimatedOpacity(
    opacity: visible ? 1 : 0,
    duration: const Duration(milliseconds: 200),
    child: const Text('Guardado correctamente'),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.animation,
    name: 'Hero',
    purpose: 'Anima un elemento compartido entre dos rutas.',
    whenToUse:
        'Ideal para transiciones detalle-lista con imagen o avatar; usa tags únicos y evita animar widgets pesados sin necesidad.',
    properties: [
      WidgetPropertyNote(name: 'tag', comment: 'Identificador compartido entre origen y destino; debe ser único por Navigator.'),
      WidgetPropertyNote(name: 'child', comment: 'Widget visual equivalente en ambas rutas.'),
      WidgetPropertyNote(name: 'flightShuttleBuilder', comment: 'Personaliza el widget durante el vuelo si las formas difieren.'),
    ],
    example: r'''
// En la lista:
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imageUrl),
)

// En el detalle:
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imageUrl, fit: BoxFit.cover),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.animation,
    name: 'Lottie',
    purpose: 'Reproduce animaciones vectoriales JSON exportadas desde herramientas de motion design.',
    whenToUse:
        'Úsalo para estados vacíos, éxito o onboarding; limita tamaño y repeticiones para no distraer ni consumir batería.',
    properties: [
      WidgetPropertyNote(name: 'asset/network', comment: 'Carga desde assets locales para mayor confiabilidad o red para contenido dinámico.'),
      WidgetPropertyNote(name: 'width/height', comment: 'Reservan espacio y evitan saltos de layout.'),
      WidgetPropertyNote(name: 'repeat/reverse/autoPlay', comment: 'Controlan reproducción; desactiva repeat en confirmaciones breves.'),
      WidgetPropertyNote(name: 'controller', comment: 'Permite sincronizar con AnimationController cuando necesitas control exacto.'),
    ],
    example: r'''
// Requiere agregar el paquete lottie e importar package:lottie/lottie.dart.
Lottie.asset(
  'assets/animations/success.json',
  width: 180,
  height: 180,
  repeat: false,
  autoPlay: true,
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.navigation,
    name: 'Navigator',
    purpose: 'Gestiona una pila de rutas para navegar entre pantallas.',
    whenToUse:
        'Usa Navigator.push/pop para flujos simples; considera Router/go_router en apps grandes con URLs, deep links o navegación declarativa.',
    properties: [
      WidgetPropertyNote(name: 'push', comment: 'Agrega una nueva pantalla encima de la actual.'),
      WidgetPropertyNote(name: 'pop', comment: 'Vuelve a la pantalla anterior y puede devolver un resultado.'),
      WidgetPropertyNote(name: 'pushNamed', comment: 'Usa rutas registradas; facilita navegación centralizada.'),
      WidgetPropertyNote(name: 'MaterialPageRoute', comment: 'Ruta con transición Material y builder perezoso.'),
    ],
    example: r'''
final saved = await Navigator.push<bool>(
  context,
  MaterialPageRoute(builder: (_) => const EditProfilePage()),
);

if (saved == true && context.mounted) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil actualizado')));
}
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.navigation,
    name: 'PageView',
    purpose: 'Permite desplazamiento paginado horizontal o vertical entre páginas.',
    whenToUse:
        'Úsalo en onboarding, carruseles y galerías; evita cargar páginas pesadas innecesarias y sincroniza indicadores con PageController.',
    properties: [
      WidgetPropertyNote(name: 'controller', comment: 'Controla página actual, viewportFraction y navegación programática.'),
      WidgetPropertyNote(name: 'children/itemBuilder', comment: 'children para pocas páginas; builder para páginas dinámicas o muchas.'),
      WidgetPropertyNote(name: 'onPageChanged', comment: 'Actualiza indicadores o estado externo.'),
      WidgetPropertyNote(name: 'physics', comment: 'Ajusta comportamiento de scroll o deshabilita gestos temporalmente.'),
    ],
    example: r'''
PageView.builder(
  controller: pageController,
  itemCount: onboardingPages.length,
  onPageChanged: setCurrentPage,
  itemBuilder: (_, index) => OnboardingStep(page: onboardingPages[index]),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.navigation,
    name: 'TabBarView',
    purpose: 'Contenido paginado sincronizado con TabBar.',
    whenToUse:
        'Elígelo para secciones hermanas dentro de una misma pantalla; evita usar tabs para pasos de formularios donde importa el orden.',
    properties: [
      WidgetPropertyNote(name: 'children', comment: 'Debe coincidir con la cantidad de tabs.'),
      WidgetPropertyNote(name: 'controller', comment: 'Comparte TabController con TabBar cuando no usas DefaultTabController.'),
      WidgetPropertyNote(name: 'physics', comment: 'Permite controlar si el usuario puede deslizar entre tabs.'),
    ],
    example: r'''
DefaultTabController(
  length: 3,
  child: Column(
    children: const [
      TabBar(tabs: [Tab(text: 'Todo'), Tab(text: 'Abierto'), Tab(text: 'Cerrado')]),
      Expanded(
        child: TabBarView(children: [AllTickets(), OpenTickets(), ClosedTickets()]),
      ),
    ],
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.asynchrony,
    name: 'FutureBuilder',
    purpose: 'Renderiza UI según el estado de un Future.',
    whenToUse:
        'Adecuado para una carga única; crea el Future fuera de build para no repetir llamadas en cada reconstrucción.',
    properties: [
      WidgetPropertyNote(name: 'future', comment: 'Operación asíncrona; inicialízala en initState o inyéctala memoizada.'),
      WidgetPropertyNote(name: 'initialData', comment: 'Datos temporales mientras llega el resultado.'),
      WidgetPropertyNote(name: 'builder', comment: 'Lee AsyncSnapshot para loading, error o data.'),
      WidgetPropertyNote(name: 'snapshot.connectionState', comment: 'Distingue waiting, done y otros estados.'),
      WidgetPropertyNote(name: 'snapshot.error', comment: 'Muestra fallback comprensible y registra detalles técnicos fuera de UI.'),
    ],
    example: r'''
FutureBuilder<List<User>>(
  future: usersFuture, // No lo crees directamente dentro de build.
  builder: (_, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) return Text('Error: ${snapshot.error}');
    final users = snapshot.data ?? const <User>[];
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, index) => Text(users[index].name),
    );
  },
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.asynchrony,
    name: 'StreamBuilder',
    purpose: 'Renderiza UI que cambia con eventos continuos de un Stream.',
    whenToUse:
        'Úsalo para sockets, Firebase, sensores o BLoCs simples; cancela streams propios y evita streams recreados en build.',
    properties: [
      WidgetPropertyNote(name: 'stream', comment: 'Fuente de eventos; debe ser estable entre builds.'),
      WidgetPropertyNote(name: 'initialData', comment: 'Evita pantallas vacías antes del primer evento.'),
      WidgetPropertyNote(name: 'builder', comment: 'Actualiza UI por cada evento; mantén trabajo pesado fuera.'),
      WidgetPropertyNote(name: 'snapshot.hasData/hasError', comment: 'Maneja datos, errores y desconexión explícitamente.'),
    ],
    example: r'''
StreamBuilder<int>(
  stream: unreadCountStream,
  initialData: 0,
  builder: (_, snapshot) => Badge(
    label: Text('${snapshot.data ?? 0}'),
    child: const Icon(Icons.notifications),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.utilities,
    name: 'CustomScrollView / SliverList',
    purpose: 'Combina múltiples regiones desplazables eficientes en un solo scroll.',
    whenToUse:
        'Elígelo para pantallas con SliverAppBar, cabeceras, listas y grillas mezcladas; evita anidar varios scrolls que compiten por gestos.',
    properties: [
      WidgetPropertyNote(name: 'slivers', comment: 'Colección de SliverAppBar, SliverList, SliverGrid, SliverToBoxAdapter, etc.'),
      WidgetPropertyNote(name: 'SliverChildBuilderDelegate', comment: 'Construye elementos perezosamente para rendimiento en listas grandes.'),
      WidgetPropertyNote(name: 'pinned/floating', comment: 'En SliverAppBar controlan si la barra queda fija o reaparece al desplazar.'),
      WidgetPropertyNote(name: 'SliverToBoxAdapter', comment: 'Inserta un widget normal dentro de una estructura sliver.'),
    ],
    variants: [
      WidgetVariantNote(name: 'SliverList', comment: 'Lista perezosa dentro de CustomScrollView.'),
      WidgetVariantNote(name: 'SliverGrid', comment: 'Grilla perezosa combinable con otros slivers.'),
      WidgetVariantNote(name: 'NestedScrollView', comment: 'Útil para tabs con app bar colapsable, pero más complejo.'),
    ],
    example: r'''
CustomScrollView(
  slivers: [
    const SliverAppBar(pinned: true, title: Text('Catálogo')),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text(items[index].title)),
        childCount: items.length,
      ),
    ),
  ],
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.utilities,
    name: 'ReorderableListView',
    purpose: 'Permite reordenar elementos de una lista mediante drag and drop.',
    whenToUse:
        'Úsalo cuando el orden sea parte del dato, como prioridades o playlists; cada hijo necesita key estable para conservar identidad.',
    properties: [
      WidgetPropertyNote(name: 'children/itemBuilder', comment: 'children para listas cortas; builder para listas grandes.'),
      WidgetPropertyNote(name: 'onReorder', comment: 'Actualiza la colección moviendo el ítem de oldIndex a newIndex.'),
      WidgetPropertyNote(name: 'Key', comment: 'Obligatoria para cada fila; usa IDs reales, no índices si el orden cambia.'),
      WidgetPropertyNote(name: 'proxyDecorator', comment: 'Personaliza apariencia del elemento mientras se arrastra.'),
    ],
    example: r'''
ReorderableListView.builder(
  itemCount: tasks.length,
  onReorder: moveTask,
  itemBuilder: (_, index) => ListTile(
    key: ValueKey(tasks[index].id), // Identidad estable.
    title: Text(tasks[index].title),
    leading: const Icon(Icons.drag_handle),
  ),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.utilities,
    name: 'Draggable / DragTarget',
    purpose: 'Implementa interacciones de arrastrar y soltar entre widgets.',
    whenToUse:
        'Úsalo para tableros, constructores visuales o juegos; añade alternativas táctiles/accesibles porque drag and drop puede ser difícil para algunos usuarios.',
    properties: [
      WidgetPropertyNote(name: 'data', comment: 'Valor transportado durante el drag.'),
      WidgetPropertyNote(name: 'feedback', comment: 'Widget que sigue el dedo/cursor; normalmente usa Material para sombras/texto.'),
      WidgetPropertyNote(name: 'childWhenDragging', comment: 'Representación del origen mientras se arrastra.'),
      WidgetPropertyNote(name: 'onAcceptWithDetails', comment: 'En DragTarget recibe dato y posición para actualizar estado.'),
      WidgetPropertyNote(name: 'canAcceptWithDetails', comment: 'Filtra qué elementos puede recibir el destino.'),
    ],
    example: r'''
Draggable<Task>(
  data: task,
  feedback: Material(child: TaskCard(task: task)),
  childWhenDragging: Opacity(opacity: 0.4, child: TaskCard(task: task)),
  child: TaskCard(task: task),
)

DragTarget<Task>(
  onAcceptWithDetails: (details) => moveToDone(details.data),
  builder: (_, candidates, __) => DoneColumn(highlighted: candidates.isNotEmpty),
)
''',
  ),
  FlutterWidgetCatalogEntry(
    category: FlutterWidgetCategory.utilities,
    name: 'ExpansionTile',
    purpose: 'Muestra/oculta contenido secundario dentro de una lista o sección.',
    whenToUse:
        'Ideal para FAQs, filtros o detalles opcionales; no escondas información crítica que el usuario necesita para completar una tarea.',
    properties: [
      WidgetPropertyNote(name: 'title/subtitle', comment: 'Resumen visible cuando está cerrado.'),
      WidgetPropertyNote(name: 'children', comment: 'Contenido expandido; mantenlo razonablemente ligero.'),
      WidgetPropertyNote(name: 'initiallyExpanded', comment: 'Abre por defecto cuando la sección es prioritaria.'),
      WidgetPropertyNote(name: 'maintainState', comment: 'Conserva estado interno de children a costa de memoria.'),
      WidgetPropertyNote(name: 'onExpansionChanged', comment: 'Permite analytics o cargar datos bajo demanda.'),
    ],
    example: r'''
ExpansionTile(
  title: const Text('Detalles del pedido'),
  subtitle: Text(order.statusLabel),
  maintainState: true,
  children: [
    ListTile(title: Text('Total: ${order.totalFormatted}')),
    ListTile(title: Text('Entrega: ${order.deliveryDate}')),
  ],
)
''',
  ),
];

/// Catálogo agrupado por categoría para construir índices o menús.
Map<FlutterWidgetCategory, List<FlutterWidgetCatalogEntry>> get widgetCatalogByCategory {
  final grouped = <FlutterWidgetCategory, List<FlutterWidgetCatalogEntry>>{};
  for (final entry in flutterWidgetCatalog) {
    grouped.putIfAbsent(entry.category, () => <FlutterWidgetCatalogEntry>[]).add(entry);
  }
  return grouped;
}

/// Devuelve entradas cuyo nombre, propósito o recomendación contenga [query].
///
/// Es útil para pantallas internas de documentación o buscadores de snippets.
List<FlutterWidgetCatalogEntry> searchWidgetCatalog(String query) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return flutterWidgetCatalog;
  }

  return flutterWidgetCatalog.where((entry) {
    return entry.name.toLowerCase().contains(normalizedQuery) ||
        entry.purpose.toLowerCase().contains(normalizedQuery) ||
        entry.whenToUse.toLowerCase().contains(normalizedQuery);
  }).toList(growable: false);
}
