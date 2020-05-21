import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Instituition.dart';

abstract class ParticularInstituitionsInformationState extends Equatable {
  const ParticularInstituitionsInformationState();
}

class InitialParticularInstituitionsInformationState extends ParticularInstituitionsInformationState {
  @override
  List<Object> get props => [];
}

class InstituitionsInfoLoaded extends ParticularInstituitionsInformationState{


  Map<String,Instituition> instituitionsMap;


  InstituitionsInfoLoaded(this.instituitionsMap);

  @override
  List<Object> get props => [instituitionsMap];

  @override
  String toString() {
    return "instituitionsMap: " + instituitionsMap.toString();
  }
}
