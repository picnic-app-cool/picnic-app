const groupsQuery = '''
    query{
        feedGroups(){
            group{
                name
            }
            topCircles{
                id
                name
                image
            }
        }
    }
''';
