class BroWhereQuery {
  String _field;
  dynamic _isEqualTo;
  dynamic _isLessThan;
  dynamic _isLessThanOrEqualTo;
  dynamic _isGreaterThan;
  dynamic _isGreaterThanOrEqualTo;
  dynamic _arrayContains;
  bool _isNull;

  BroWhereQuery(
    field, {
    isEqualTo,
    isLessThan,
    isLessThanOrEqualTo,
    isGreaterThan,
    isGreaterThanOrEqualTo,
    arrayContains,
    isNull,
  })  : _field = field,
        _isEqualTo = isEqualTo,
        _isLessThan = isLessThan,
        _isLessThanOrEqualTo = isLessThanOrEqualTo,
        _isGreaterThan = isGreaterThan,
        _isGreaterThanOrEqualTo = isGreaterThanOrEqualTo,
        _arrayContains = arrayContains,
        _isNull = isNull;

  operator +(BroWhereQuery qw) {
    if (qw == null) return this;

    _field ??= qw.field;
    _isEqualTo ??= qw.isEqualTo;
    _isLessThan ??= qw.isLessThan;
    _isLessThanOrEqualTo ??= qw.isLessThanOrEqualTo;
    _isGreaterThan ??= qw.isGreaterThan;
    _isGreaterThanOrEqualTo ??= qw.isGreaterThanOrEqualTo;
    _arrayContains ??= qw.arrayContains;
    _isNull ??= qw.isNull;
  }

  get field => _field;
  get isEqualTo => _isEqualTo;
  get isLessThan => _isLessThan;
  get isLessThanOrEqualTo => _isLessThanOrEqualTo;
  get isGreaterThan => _isGreaterThan;
  get isGreaterThanOrEqualTo => _isGreaterThanOrEqualTo;
  get arrayContains => _arrayContains;
  get isNull => _isNull;
}
