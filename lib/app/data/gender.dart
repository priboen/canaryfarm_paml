enum Gender { jantan, betina }

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.jantan:
        return "Jantan";
      case Gender.betina:
        return "Betina";
      default:
        return "";
    }
  }

  static Gender fromString(String gender) {
    switch (gender.toLowerCase()) {
      case 'jantan':
        return Gender.jantan;
      case 'betina':
        return Gender.betina;
      default:
        return Gender.jantan;
    }
  }
}
