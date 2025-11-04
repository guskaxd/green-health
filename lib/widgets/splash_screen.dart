import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configura o AnimationController e a duração
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define o Tween para a animação de opacidade e escala
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Inicia a animação
    _controller.forward();

    // Após a animação, navega para a Home
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    // Libera o controlador quando o widget for descartado
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100, // Fundo suave
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone com fade-in suave
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'lib/assets/icons/app_splash.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            // Texto animado com crescimento
            FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: Text(
                  'Saúde Verde',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight
                        .w900, // Espessura da fonte mais pesada para destaque
                    color: Color.fromARGB(255, 20, 172, 134),
                    letterSpacing:
                        2.0, // Aumenta um pouco o espaçamento entre as letras
                    shadows: [
                      Shadow(
                        blurRadius: 5.0, // Aumenta a suavidade da sombra
                        color: const Color.fromARGB(255, 3, 34, 26)
                            .withOpacity(0.3), // Cor da sombra sutil
                        offset: const Offset(
                            3.0, 3.0), // Direção da sombra (direita e abaixo)
                      ),
                    ],
                    fontFamily:
                        'CustomFont', // Utilize uma fonte customizada se tiver
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Subtexto animado
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Cuidando da sua saúde naturalmente',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  letterSpacing: 1.2,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
