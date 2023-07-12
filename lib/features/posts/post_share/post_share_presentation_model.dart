import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_share_app.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/share_recommendation_displayable.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostSharePresentationModel implements PostShareViewModel {
  /// Creates the initial state
  PostSharePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostShareInitialParams initialParams,
  )   : post = initialParams.post,
        recommendations = PaginatedListPresentationModel(),
        message = '';

  /// Used for the copyWith method
  PostSharePresentationModel._({
    required this.post,
    required this.recommendations,
    required this.message,
  });

  final Post post;

  final PaginatedListPresentationModel<ShareRecommendationDisplayable> recommendations;

  final String message;

  @override
  PaginatedList<ShareRecommendationDisplayable> get recommendationsList => recommendations.paginatedList;

  @override
  List<PostShareApp> get postShareApps => PostShareApp.values;

  PostSharePresentationModel byUpdatingSendState({
    required bool isSent,
    required Id chatId,
  }) {
    final recommendationsList = recommendations.paginatedList.mapItems(
      (recommendation) =>
          recommendation.chatDisplayable.chat.id == chatId ? recommendation.copyWith(isSent: isSent) : recommendation,
    );

    return copyWith(
      recommendations: recommendations.copyWith(paginatedList: recommendationsList),
    );
  }

  PostSharePresentationModel copyWith({
    Post? post,
    PaginatedListPresentationModel<ShareRecommendationDisplayable>? recommendations,
    String? message,
  }) {
    return PostSharePresentationModel._(
      post: post ?? this.post,
      recommendations: recommendations ?? this.recommendations,
      message: message ?? this.message,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostShareViewModel {
  List<PostShareApp> get postShareApps;

  PaginatedList<ShareRecommendationDisplayable> get recommendationsList;
}
