
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'electronic_sebha_viewModel/electronic_sebha_viewModel.dart';


class SebhaView extends StatelessWidget {
  const SebhaView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SebhaViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE7E0D0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E0D0),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "السبحة الالكترونية",
          style: TextStyle(
              color: Color(0xFFCB3526),
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Inter'
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFFCB3526),
            thickness: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "العدات",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,fontFamily: 'Inter'),
              ),
              const SizedBox(height: 20),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFECC5B8),
                  border: Border.all(color: const Color(0xFFE09991)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${viewModel.count}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Color(0xFF152D45),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF155F5E),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: viewModel.increment,
                child: const Text(
                  "اضغط هنا للعد",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Inter'),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCB3526), // Different color for reset
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: viewModel.reset,
                child: const Text(
                  "إعادة التصفير",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
