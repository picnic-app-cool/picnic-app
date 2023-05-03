import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

const String electionVoteMutation = """
mutation electionVote(\$electionId: ID!, \$nomineeId: ID!) {
    electionVote(electionVoteInput: {
        nomineeId:\$nomineeId,
        electionId:\$electionId

    }) {
        userId
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

String electionParticipantsConnection = """
query getCircleById(\$circleId: ID!, \$cursor: CursorInput!,  \$votes: Boolean! ) {
  electionParticipantsConnection(
    electionParticipantsConnectionInput: {circleId: \$circleId, votes: \$votes, cursor: \$cursor}
  ) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().electionCandidate)}
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

String getSeedElectionQuery = """
query(\$circleId: ID!) {
  getElection(
    electionInput: { 
      circleId: \$circleId
    }
  ){
    id
    circleId
    dueTo 
    membersVoted 
    seedsVoted 
    maxSeedsVoted
    iVoted
    circleMembersCount
    votesPercent
    isSeedHolder
  }
}
""";
