class ExtractionResult {
  final String folio;
  final String cr;

  ExtractionResult({required this.folio, required this.cr});
}

class TextParser {
  static ExtractionResult? parse(String text) {
    if (text.isEmpty) return null;

    // Folio: 15 caracteres iniciando con INC (INC + 12 digitos) o despues de Asignacion
    final folioMatch = RegExp(r'(INC\d{12})\b', caseSensitive: false).firstMatch(text);
    
    // CR: Inicia despues de ASIGNADO, toma los 4 digitos y el nombre hasta encontrar la direccion o fin de linea
    final crMatch = RegExp(
      r'ASIGNADO\s+(\d{4}\s+.*?)(?=\s+(?:Av\.|Ave\.|Avenida|Via|Vía|Calle|Blvd\.?|Boulevard|Calzada|Calz\.?|Camino|Paseo|c\.|C\.|Prol\.?|Prolongación|Autopista|Carretera|Carr\.?)(?:\s|$)|\r|\n|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (folioMatch != null && crMatch != null) {
      return ExtractionResult(
        folio: folioMatch.group(1)!.toUpperCase(),
        cr: crMatch.group(1)!.trim().toUpperCase(),
      );
    }
    return null;
  }
}
