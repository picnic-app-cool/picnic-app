import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class GraphQLUnauthenticatedFailureHandler {
  /// [GraphQLUnauthenticatedFailureHandler] calls [SessionInvalidatedListenersContainer.] whenever graphql
  /// request fails with token expired error
  GraphQLUnauthenticatedFailureHandler(
    this.sessionInvalidatedListenersContainer,
    this._authTokenRepository,
  );

  @visibleForTesting
  final SessionInvalidatedListenersContainer sessionInvalidatedListenersContainer;
  StreamSubscription<AuthToken>? _tokenListeningSubscription;

  final AuthTokenRepository _authTokenRepository;

  int? _accessTokenHashCode;

  bool _registeredListener = false;

  Future<gql.ContextEntry> prepareContextEntry() async {
    if (!_registeredListener) {
      await _registerListener();
    }

    return GraphQLUnauthenticatedContextEntry(_accessTokenHashCode);
  }

  Future<void> handle({
    required int? tokenHashCode,
  }) async {
    if (tokenHashCode == null) {
      return;
    }
    await sessionInvalidatedListenersContainer.onSessionInvalidated(
      tokenHashCode: tokenHashCode,
    );
  }

  void dispose() {
    _tokenListeningSubscription?.cancel();
  }

  Future<void> _registerListener() async {
    _accessTokenHashCode = await _authTokenRepository.getAuthToken().asyncFold(
          (fail) => null,
          (value) => value.accessToken.hashCode,
        );
    _tokenListeningSubscription = _authTokenRepository.listenAuthToken().listen(
          (value) => _accessTokenHashCode = value.accessToken.hashCode,
          onError: (fail) => logError(fail, stack: StackTrace.current),
        );
    _registeredListener = true;
  }
}

class GraphQLUnauthenticatedContextEntry extends gql.ContextEntry {
  const GraphQLUnauthenticatedContextEntry(this.tokenHashCode);

  final int? tokenHashCode;

  @override
  List<Object?> get fieldsForEquality => [tokenHashCode];
}
