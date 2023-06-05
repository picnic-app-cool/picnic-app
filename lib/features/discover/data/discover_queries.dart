String groupsQuery = '''
    query{
        feedGroups(){
            group{
                name
            }

            topCircles{
                id
                name
                image
                shareLink
                description
                coverImageFile
                membersCount
                iJoined
                chat{
                id
                }
            }
        }
    }
''';
