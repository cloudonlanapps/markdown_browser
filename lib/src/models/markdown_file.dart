// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarkDownFile {
  final String urlBase;
  final String landingPage;
  final bool isOnline;
  final String? currentSection;

  MarkDownFile({
    required this.urlBase,
    required this.landingPage,
    this.currentSection,
  }) : isOnline =
            urlBase.startsWith("http://") || urlBase.startsWith("https://");

  MarkDownFile copyWith({String? landingPage, String? currentSection}) {
    return MarkDownFile(
      urlBase: urlBase,
      landingPage: landingPage ?? this.landingPage,
      currentSection: currentSection ?? this.currentSection,
    );
  }

  String get path => "$urlBase/$landingPage";

  MarkDownFile newPage({required String landingPage, String? currentSection}) {
    return copyWith(landingPage: landingPage, currentSection: currentSection);
  }

  @override
  String toString() {
    return 'MarkDownFile(urlBase: $urlBase, landingPage: $landingPage, isOnline: $isOnline, currentSection: $currentSection)';
  }
}
