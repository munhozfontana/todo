abstract class IBusinessException {
  final String message;
  final StackTrace? stackTrace;

  IBusinessException(this.message, [this.stackTrace]);
}

class ArgumentsException extends IBusinessException {
  ArgumentsException(super.message, [super.stackTrace]);
}

class RepositoryException extends IBusinessException {
  RepositoryException(super.message, [super.stackTrace]);
}

class AdapterException extends RepositoryException {
  AdapterException(super.message, [super.stackTrace]);
}

class ExternalException extends RepositoryException {
  ExternalException(super.message, [super.stackTrace]);
}
