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
}
