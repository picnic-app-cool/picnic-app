import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/data/model/gql_create_post_input.dart';
import 'package:picnic_app/features/posts/data/posts_queries.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

typedef CreatePostBackgroundCallStatus = BackgroundCallStatus<Post, CreatePostFailure, Post>;

class CreatePostGraphQLBackgroundCall implements BackgroundCall<Post, CreatePostFailure, Post> {
  CreatePostGraphQLBackgroundCall({
    Id? id,
    required this.input,
    required this.gqlClient,
    required this.userStore,
  }) : id = id ?? Id.unique() {
    final author = userStore.privateProfile.toBasicPublicProfile();
    entity = input.toPost().copyWith(author: author);
    status = BackgroundCallStatusInProgress(
      id: this.id,
      entity: entity,
      percentage: 0,
    );
  }

  CreatePostGraphQLBackgroundCall._({
    required this.input,
    required this.gqlClient,
    required this.userStore,
    required this.id,
    required this.entity,
    required this.status,
  });

  final CreatePostInput input;
  final GraphQLClient gqlClient;
  final UserStore userStore;

  @override
  final Id id;

  @override
  late final Post entity;

  @override
  late final BackgroundCallStatus<Post, CreatePostFailure, Post> status;

  @override
  Future<Either<CreatePostFailure, Post>> execute() {
    return gqlClient
        .mutate(
          document: createPostMutation,
          parseData: (json) {
            return GqlPost.fromJson(json['createPost'] as Map<String, dynamic>);
          },
          variables: {
            'data': GqlCreatePostInput.fromDomain(input).toJson(),
            BackgroundApiRepository.requestUniqueId: id.value,
          },
        )
        .mapSuccess(
          (response) => response.toDomain(
            userStore,
          ),
        )
        .mapFailure(
          (fail) => fail.isFileSizeTooBig ? CreatePostFailure.fileTooBig(fail) : CreatePostFailure.unknown(fail),
        );
  }

  @override
  CreatePostGraphQLBackgroundCall byUpdatingStatus(
    BackgroundCallStatus<Post, CreatePostFailure, Post> status,
  ) =>
      copyWith(status: status);

  CreatePostGraphQLBackgroundCall copyWith({
    CreatePostInput? input,
    GraphQLClient? gqlClient,
    UserStore? userStore,
    Id? id,
    Post? entity,
    BackgroundCallStatus<Post, CreatePostFailure, Post>? status,
  }) {
    return CreatePostGraphQLBackgroundCall._(
      input: input ?? this.input,
      gqlClient: gqlClient ?? this.gqlClient,
      userStore: userStore ?? this.userStore,
      id: id ?? this.id,
      entity: entity ?? this.entity,
      status: status ?? this.status,
    );
  }
}

extension CreatePostInputMapper on CreatePostInput {
  Post toPost() => const Post.empty().copyWith(
        content: content.toPostContent(),
        sound: sound,
      );
}
