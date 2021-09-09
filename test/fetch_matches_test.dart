import 'package:flutter_test/flutter_test.dart';
import 'package:nhl_tournament/core/models/match.dart';
import 'package:nhl_tournament/core/networking/api_repository.dart';
import 'package:nhl_tournament/core/viewmodels/matches_viewmodel.dart';
import 'package:nhl_tournament/helpers/dependency_assembly.dart';

class MockAPI extends ApiRepository {
  @override
  Future<List<Game>> getAllMatches() async {
    return Future.value([
      Game('001', 'Tampa Bay X Columbus', 'Eastern Conference', 1, 'Columbus',
          'Ok', '005'),
      Game('005', 'Nashville X Dallas', 'Western Conference', 1, 'Dallas', 'Ok',
          '0011'),
      Game('015', 'Boston X St.Louis', '', 4, 'St.Louis', 'Ok', '0011')
    ]);
  }
}

void main() {
  setupDependencyAssembler();
  var viewModel = dependencyAssembler<MatchesViewModel>();
  viewModel.apiRepository = MockAPI();

  group('Given Match List Page Loads', () {
    test('Page should load a list of matches from mock server', () async {
      await viewModel.fetchAllMatches();
      expect(viewModel.allMatches.length, 3);
      expect(viewModel.allMatches[0].title, 'Tampa Bay X Columbus');
      expect(viewModel.allMatches[0].round, 1);
      expect(viewModel.allMatches[1].id, '005');
      expect(viewModel.allMatches[1].winner, 'Dallas');
    });
    test('Check next match', () async {
      await viewModel.fetchAllMatches();
      expect(viewModel.getNextMatch(viewModel.allMatches[0]),
          viewModel.allMatches[1]);
    });

    test('Check final match', () async {
      await viewModel.fetchAllMatches();
      expect(viewModel.isFinal(viewModel.allMatches[2]), true);
      expect(viewModel.isFinal(viewModel.allMatches[1]), false);
    });

    test('Check round title', () async {
      await viewModel.fetchAllMatches();
      expect(viewModel.getRound(viewModel.allMatches[1]), 'Second Round');
    });
  });
}
