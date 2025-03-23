import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reze_melhor/application/services/secure_storage_service.dart';
import 'package:reze_melhor/ui/components/custom_button.dart';
import 'package:reze_melhor/ui/screens/material/hoje_screen.dart';

class WelcomeScreen extends StatelessWidget {
    WelcomeScreen({super.key});

  final storageService = Get.find<SecureStorageService>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  Widget build(BuildContext context) { 
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Bem-vindo",
          backgroundImage: "assets/img/cristo-manto.jpg", 
          decoration: PageDecoration(  
            bodyAlignment: Alignment.bottomCenter,
            bodyPadding: EdgeInsets.all(10), 
          ),
          body: "Esta é a primeira tela do onboarding.",
        ),
        PageViewModel(
          title: "Bem-vindo",
          backgroundImage: "assets/img/cristo-crucificado.jpg", 
          decoration: PageDecoration(  
            bodyAlignment: Alignment.bottomCenter,
            bodyPadding: EdgeInsets.all(10), 
          ),
          body: "Esta é a primeira tela do onboarding.",
        ),
      ],
      allowImplicitScrolling: true,
      onDone: () {
        
      },
      showSkipButton: true,
      skip: CustomButton(onPress: (){}, textButton: "Pular"),
      next: CustomButton(onPress: (){}, textButton: "Próximo"),
      done: CustomButton(onPress: (){
        Get.to(HojeScreen(openDrawer: () => scaffoldKey.currentState?.openDrawer()));
      }, textButton: "Concluir"),
    );
  }
}
