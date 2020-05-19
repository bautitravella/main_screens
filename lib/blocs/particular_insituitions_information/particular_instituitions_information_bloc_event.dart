import 'package:equatable/equatable.dart';
import 'package:flutterui/Models/Instituition.dart';

abstract class ParticularInstituitionsInformationEvent extends Equatable {
  const ParticularInstituitionsInformationEvent();
}

class LoadInstituitionInfo extends ParticularInstituitionsInformationEvent{

  String instituition;
  List<String> instituitionsName;
  LoadInstituitionInfo({ this.instituition,this.instituitionsName});

  @override
  List<Object> get props => [instituition,instituitionsName];
}

class LoadedInstituitionsInfo extends ParticularInstituitionsInformationEvent{

  LoadedInstituitionsInfo();

  @override
  List<Object> get props => [];

}



