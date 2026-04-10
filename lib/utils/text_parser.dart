class ExtractionResult {
  final String folio;
  final String cr;

  ExtractionResult({required this.folio, required this.cr});
}

class TextParser {
  static ExtractionResult? parse(String rawText) {
    if (rawText.isEmpty) return null;

    // Limpiamos los asteriscos provenientes del formato de negritas de WhatsApp
    final text = rawText.replaceAll('*', '');

    // Folio: 15 caracteres iniciando con INC (INC + 12 digitos)
    final folioMatch = RegExp(r'(INC\d{12})\b', caseSensitive: false).firstMatch(text);
    
    // CR: Inicia despues de ASIGNADO o mismamente al principio de cualquier linea, toma los 4 digitos y el nombre hasta encontrar direccion o salto de linea
    final crMatch = RegExp(
      r'(?:ASIGNADO\s+|(?:^|\n)\s*)(\d{4}\s+.*?)(?:\r|\n|(?=\s+(?:Av\.|Ave\.|Avenida|Via|Vía|Calle|Blvd\.?|Boulevard|Calzada|Calz\.?|Camino|Paseo|c\.|C\.|Prol\.?|Prolongación|Autopista|Carretera|Carr\.?)(?:\s|$)))',
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
