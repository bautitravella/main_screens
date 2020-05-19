import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:flutterui/Models/Instituition.dart';
import 'package:flutterui/blocs/database_repository.dart';
import './bloc.dart';

class ParticularInstituitionsInformationBloc extends Bloc<
    ParticularInstituitionsInformationEvent,
    ParticularInstituitionsInformationState> {

  Map<String,Instituition> instituitionsCache = new SplayTreeMap();
  Map<String,int> instituitionsRefreshCount = new SplayTreeMap();
  final DatabaseRepository databaseRepository;
  int REFRESH_THRESHOLD = 2;

  ParticularInstituitionsInformationBloc(this.databaseRepository);


  @override
  ParticularInstituitionsInformationState get initialState =>
      InitialParticularInstituitionsInformationState();

  @override
  Stream<ParticularInstituitionsInformationState> mapEventToState(
    ParticularInstituitionsInformationEvent event,
  ) async* {
    if (event is LoadInstituitionInfo) {
      mapLoadInstituitionsInfoToState(event.instituitionsName, event.instituition);
    } else if (event is LoadedInstituitionsInfo) {
      yield* mapLoadedInstituitionsInfoToState();
    }
  }

  void mapLoadInstituitionsInfoToState(
      List<String> instituitionsToLoad, String instituitionToLoad) {

    List<String> newInstituitions;
    if(instituitionToLoad !=null){
      newInstituitions = [instituitionToLoad];
    }else{
      newInstituitions = instituitionsToLoad;
    }

    for(String instituition in newInstituitions){

      if(instituitionsCache.containsKey(instituition)){
        Instituition aux = instituitionsCache[instituition];
        int auxCount = instituitionsRefreshCount[instituition]++;

        //auxCount++;
        if(auxCount >= REFRESH_THRESHOLD){
          databaseRepository.getParticularInstituitionInfo(instituition).then((info){
            if(info !=null){
              instituitionsRefreshCount[instituition] = 0;
              aux = info;
              add(LoadedInstituitionsInfo());
            }
          });
        }
      }else{
        databaseRepository.getParticularInstituitionInfo(instituition).then((info){
          if(info !=null){
            instituitionsCache[instituition] = info;
            instituitionsRefreshCount[instituition] = 0;
            add(LoadedInstituitionsInfo());
          }
        });
      }


    }


  }

  mapLoadedInstituitionsInfoToState() async*{

    yield InstituitionsInfoLoaded(instituitionsCache);
  }
}

class InstituitionCache {
  Instituition instituition;
  int count = 0;

  InstituitionCache(this.instituition);

  incrementCount(){
    count++;
  }


}
