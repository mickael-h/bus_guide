const planningsExample = <String, dynamic>{
  'plannings': [
    {
      'date': {'_seconds': 1597874400, '_nanoseconds': 0},
      'general_comment': 'Commentaire trajet',
      'line_name': '119',
      'located_comments': [
        {
          'position': {'_latitude': 46.123456, '_longitude': 5.123456},
          'text': 'Commentaire localisé',
        },
      ],
      'schedule': {
        'times': [
          {'_seconds': 20700, '_nanoseconds': 0},
          {'_seconds': 21180, '_nanoseconds': 0},
        ],
        'name': 'Express Bourg-en-Bresse -> Villefranche-sur-Saône 6:45',
        'is_reversed': false,
        'trip': {
          'stops': [
            {
              'position': {'_latitude': 46.208185, '_longitude': 5.2263725},
              'name': 'Carré Amiot',
            },
            {
              'name': 'Bourg-en-Bresse Gare SNCF',
              'position': {'_latitude': 46.1990888, '_longitude': 5.2143643}
            },
          ],
          'name': 'Express',
        },
      },
    },
  ],
};
