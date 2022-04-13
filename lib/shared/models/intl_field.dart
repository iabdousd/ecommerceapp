class IntlField {
  final Map<String, String> localizations;
  final String fallback;

  IntlField({required this.localizations, required this.fallback});

  String operator [](String locale) => localizations[locale] ?? fallback;

  Map<String, dynamic> get toMap => {
        'localizations': localizations,
        'fallback': fallback,
      };

  factory IntlField.fromMap(Map<String, dynamic> map) {
    return IntlField(
      localizations: Map<String, String>.from(map['localizations'] ?? {}),
      fallback: map['fallback'] ?? '',
    );
  }
}
