String get getGeneratedAppTokenMutation => '''
    mutation(\$appID: ID!) {
        generateUserScopedAppToken(
          appID: \$appID, 
        ) {
            tokenID
            jwtToken
        }
    }
''';
