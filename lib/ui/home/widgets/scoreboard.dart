import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhl/ui/home/bloc/bloc.dart';
import 'package:nhl/ui/home/bloc/game_bloc.dart';
import 'package:nhl/ui/home/widgets/match_card.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard(this.round, this.state, {Key? key}) : super(key: key);

  final int round;
  final GameState state;
  @override
  Widget build(BuildContext context) {
    Widget _getChild() {
      if (state.currentRound == round) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return MatchInfoCard(
                    home: state.currentRoundInfo![index].home,
                    away: state.currentRoundInfo![index].away,
                  );
                },
                itemCount: state.currentRoundInfo!.length,
              ),
            ),
            Container(
              height: 64,
              width: double.maxFinite,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                child: Text("Start Round $round"),
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                onPressed: () {
                  BlocProvider.of<GameBloc>(context).play();
                },
              ),
            ),
          ],
        );
      } else if (state.currentRound > round) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return MatchResultCard(
                home: state.completedRoundsData[round - 1][index].home,
                away: state.completedRoundsData[round - 1][index].away);
          },
          itemCount: state.completedRoundsData[round - 1].length,
        );
      } else {
        return Center(child: Text('No Data Available'));
      }
    }

    return Container(margin: EdgeInsets.all(16), child: _getChild());
  }
}
