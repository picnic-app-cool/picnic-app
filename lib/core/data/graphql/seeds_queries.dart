import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_director_vote.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String voteForDirectorMutation = """
mutation voteForDirector(\$circleId: ID!, \$userId: ID!) {
    voteForDirector(
        userId:\$userId,
        circleId:\$circleId
    ) {
      ${GqlTemplate().successPayload}  
    }
}
""";

const String getPrivateProfileSeeds = """
query myProfile( \$cursor: CursorInput!) {
 myProfile {
   id
   username
   melonsAmount
   seeds(cursor: \$cursor) {
   totalSeedsAmount
     edges {
       cursorId
       node {
          circle {
            id
            name
            membersCount
            viewsCount
            postsCount
            image
            imageFile
          }
          amountAvailable
          amountLocked
          amountTotal
        }
      }
      pageInfo {
        firstId
        lastId
        hasNextPage
        hasPreviousPage
        length
      }
    }
  }
}
""";

String searchVoteCandidatesQuery = """
query searchVoteCandidate(\$circleId: ID!, \$cursor: CursorInput!, \$search: String!) {
  searchVoteCandidates(
      circleId: \$circleId, 
      search: \$search, 
      cursor: \$cursor
  ) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().voteCandidate)}
        }
    }
""";
const String getPrivateProfileTotalSeeds = """
query myProfile() {
 myProfile {
   seeds() {
      totalSeedsAmount
    }
  }
}
""";

const String circleSeedsConnection = """
query getCircleById(\$circleId: ID!) {
  getCircleById(
    getCircleByIdInput: {
      circleId: \$circleId,
    }
  ) {
    seedsConnection {
      edges {
        node {
          owner {
              id
              username
            profileImage

          }
          amountAvailable
          amountLocked
          amountTotal
        }
      }
    }
  }
}
""";

const String sendExchangeOffer = """
mutation sendExchangeOffer(\$melonsAmount: Int!, \$seedsAmount: Int!,\$circleId: ID!, \$recipientId: ID! ) {
  sendOffer(offerInput: {
    melonsAmount: \$melonsAmount
    seedsAmount: \$seedsAmount
    circleId: \$circleId
    recipientId: \$recipientId
  }) {
    id
    seed {
      circleId
      amount
    }
    melonsAmount
    status
  }
}
""";

String cancelExchangeOffer = """
  mutation rejectExchangeOffer(\$offerId: ID!, \$userId: ID! ) {
    cancelOffer(offerId: \$offerId, userId: \$userId) {
         ${GqlTemplate().successPayload}  
    }
  }
  """;

String transferSeedsMutation = """
mutation transferSeeds(\$seedsAmount: Int!,\$circleId: ID!, \$recipientId: ID! ) {
  transferSeeds(transferInput: {
    seedsAmount: \$seedsAmount
    circleId: \$circleId
    recipientId: \$recipientId
  }) {
     ${GqlTemplate().successPayload}  

  }
}
""";
String acceptExchangeOffer = """
mutation acceptExchangeOffer(\$offerId: ID!, \$userId: ID! ) {
  acceptOffer(offerId: \$offerId, userId: \$userId) {
       ${GqlTemplate().successPayload}  
  }
}
""";

String rejectExchangeOffer = """
   cancelOffer(offerId: \$offerId, userId: \$userId) {
        ${GqlTemplate().successPayload}  
   }
 }
 """;

String getGovernanceQuery = """
  query(\$circleId: ID!) {
    getGovernance(
        circleId: \$circleId
    ){
      circleId
      allVotesTotal 
      myVotesTotal
      mySeedsCount
      allVotes {
        ${GqlTemplate().directorVote}
      }
      myVotes {
        ${GqlTemplate().directorVote}
      }
    }
  }
""";
