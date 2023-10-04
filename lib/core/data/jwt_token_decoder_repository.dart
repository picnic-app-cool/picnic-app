import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:picnic_app/core/domain/repositories/token_decoder_repository.dart';

class JwtTokenDecoderRepository implements TokenDecoderRepository {
  @override
  bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
