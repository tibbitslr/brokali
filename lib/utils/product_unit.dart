class BroProductUnit {
  static const VOLUME = BroProductUnit._('volume');
  static const VOLUME_PACKAGES = [0.1, 0.25, 0.5, 0.75, 1, 1.5, 2];

  static const MASS = BroProductUnit._('mass');
  static const MASS_PACKAGES = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];

  static const NO_UNIT_PACKAGES = [
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1
  ];

  static BroProductUnit from(String unit) => BroProductUnit._(unit);

  final String _unit;

  const BroProductUnit._(String unit) : _unit = unit;

  List<num> get packages {
    switch (_unit) {
      case 'volume':
        return VOLUME_PACKAGES;
      case 'mass':
        return MASS_PACKAGES;
      default:
        return NO_UNIT_PACKAGES;
    }
  }

  @override
  String toString() {
    switch (_unit) {
      case 'volume':
        return 'l';
      case 'mass':
        return 'kg';
      default:
        return '';
    }
  }
}
