class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

// List of popular countries
List<CountryModel> countries = [
  CountryModel(name: "United States", code: "US", dialCode: "+1", flag: "🇺🇸"),
  CountryModel(
      name: "United Kingdom", code: "GB", dialCode: "+44", flag: "🇬🇧"),
  CountryModel(name: "Canada", code: "CA", dialCode: "+1", flag: "🇨🇦"),
  CountryModel(name: "Australia", code: "AU", dialCode: "+61", flag: "🇦🇺"),
  CountryModel(name: "Germany", code: "DE", dialCode: "+49", flag: "🇩🇪"),
  CountryModel(name: "France", code: "FR", dialCode: "+33", flag: "🇫🇷"),
  CountryModel(name: "Italy", code: "IT", dialCode: "+39", flag: "🇮🇹"),
  CountryModel(name: "Spain", code: "ES", dialCode: "+34", flag: "🇪🇸"),
  CountryModel(name: "Netherlands", code: "NL", dialCode: "+31", flag: "🇳🇱"),
  CountryModel(name: "Belgium", code: "BE", dialCode: "+32", flag: "🇧🇪"),
  CountryModel(name: "Switzerland", code: "CH", dialCode: "+41", flag: "🇨🇭"),
  CountryModel(name: "Sweden", code: "SE", dialCode: "+46", flag: "🇸🇪"),
  CountryModel(name: "Norway", code: "NO", dialCode: "+47", flag: "🇳🇴"),
  CountryModel(name: "Denmark", code: "DK", dialCode: "+45", flag: "🇩🇰"),
  CountryModel(name: "Finland", code: "FI", dialCode: "+358", flag: "🇫🇮"),
  CountryModel(name: "Poland", code: "PL", dialCode: "+48", flag: "🇵🇱"),
  CountryModel(
      name: "Czech Republic", code: "CZ", dialCode: "+420", flag: "🇨🇿"),
  CountryModel(name: "Austria", code: "AT", dialCode: "+43", flag: "🇦🇹"),
  CountryModel(name: "Portugal", code: "PT", dialCode: "+351", flag: "🇵🇹"),
  CountryModel(name: "Greece", code: "GR", dialCode: "+30", flag: "🇬🇷"),
  CountryModel(name: "Ireland", code: "IE", dialCode: "+353", flag: "🇮🇪"),
  CountryModel(name: "New Zealand", code: "NZ", dialCode: "+64", flag: "🇳🇿"),
  CountryModel(name: "Singapore", code: "SG", dialCode: "+65", flag: "🇸🇬"),
  CountryModel(name: "Japan", code: "JP", dialCode: "+81", flag: "🇯🇵"),
  CountryModel(name: "South Korea", code: "KR", dialCode: "+82", flag: "🇰🇷"),
  CountryModel(name: "China", code: "CN", dialCode: "+86", flag: "🇨🇳"),
  CountryModel(name: "India", code: "IN", dialCode: "+91", flag: "🇮🇳"),
  CountryModel(name: "Pakistan", code: "PK", dialCode: "+92", flag: "🇵🇰"),
  CountryModel(name: "Bangladesh", code: "BD", dialCode: "+880", flag: "🇧🇩"),
  CountryModel(
      name: "United Arab Emirates", code: "AE", dialCode: "+971", flag: "🇦🇪"),
  CountryModel(
      name: "Saudi Arabia", code: "SA", dialCode: "+966", flag: "🇸🇦"),
  CountryModel(name: "Turkey", code: "TR", dialCode: "+90", flag: "🇹🇷"),
  CountryModel(name: "Egypt", code: "EG", dialCode: "+20", flag: "🇪🇬"),
  CountryModel(name: "South Africa", code: "ZA", dialCode: "+27", flag: "🇿🇦"),
  CountryModel(name: "Nigeria", code: "NG", dialCode: "+234", flag: "🇳🇬"),
  CountryModel(name: "Kenya", code: "KE", dialCode: "+254", flag: "🇰🇪"),
  CountryModel(name: "Brazil", code: "BR", dialCode: "+55", flag: "🇧🇷"),
  CountryModel(name: "Mexico", code: "MX", dialCode: "+52", flag: "🇲🇽"),
  CountryModel(name: "Argentina", code: "AR", dialCode: "+54", flag: "🇦🇷"),
  CountryModel(name: "Chile", code: "CL", dialCode: "+56", flag: "🇨🇱"),
  CountryModel(name: "Colombia", code: "CO", dialCode: "+57", flag: "🇨🇴"),
  CountryModel(name: "Peru", code: "PE", dialCode: "+51", flag: "🇵🇪"),
  CountryModel(name: "Malaysia", code: "MY", dialCode: "+60", flag: "🇲🇾"),
  CountryModel(name: "Thailand", code: "TH", dialCode: "+66", flag: "🇹🇭"),
  CountryModel(name: "Vietnam", code: "VN", dialCode: "+84", flag: "🇻🇳"),
  CountryModel(name: "Philippines", code: "PH", dialCode: "+63", flag: "🇵🇭"),
  CountryModel(name: "Indonesia", code: "ID", dialCode: "+62", flag: "🇮🇩"),
  CountryModel(name: "Russia", code: "RU", dialCode: "+7", flag: "🇷🇺"),
  CountryModel(name: "Ukraine", code: "UA", dialCode: "+380", flag: "🇺🇦"),
  CountryModel(name: "Israel", code: "IL", dialCode: "+972", flag: "🇮🇱"),
];
