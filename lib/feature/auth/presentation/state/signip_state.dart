
  abstract class SignipState {}

  class  OnInitialSignipState extends SignipState  {}

  class OnLoadingSignipState extends SignipState {}

  class OnLoadedSignipState extends SignipState {
   OnLoadedSignipState();
   }
  class  OnErrorSignipState extends SignipState{
  final String errorMessage;

  OnErrorSignipState(this.errorMessage);
  }