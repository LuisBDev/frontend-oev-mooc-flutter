import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:flutter/services.dart';

class CertificadoPagoScreen extends StatefulWidget {
  final CourseEnrolled courseEnrolled;

  const CertificadoPagoScreen({super.key, required this.courseEnrolled});

  @override
  _CertificadoPagoScreenState createState() => _CertificadoPagoScreenState();
}

class _CertificadoPagoScreenState extends State<CertificadoPagoScreen> {
  String cardNumber = '';
  String cardHolder = 'NOMBRE Y APELLIDO';
  String expiryDate = 'MM/AA';

  Future<void> _selectExpiryDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(primary: Colors.blue),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        expiryDate = DateFormat('MM/yy').format(picked);
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xff1E1E2C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Pago del Certificado', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Método de pago', style: _titleStyle),
            const SizedBox(height: 10),
            _buildPaymentMethods(),
            const SizedBox(height: 20),
            _buildCreditCard(),
            const SizedBox(height: 20),
            _buildTextField('Número de la tarjeta',
                onChanged: (value) {
                  setState(() {
                    cardNumber = value.replaceAll(RegExp(r'\D'), '');
                  });
                },
                isNumber: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ]),
            _buildTextField('Nombre en la tarjeta', onChanged: (value) {
              setState(() {
                cardHolder = value.toUpperCase();
              });
            }),
            Row(
              children: [
                Expanded(
                    child: _buildTextField('CVC',
                        isNumber: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ])),
                const SizedBox(width: 10),
                Expanded(child: _buildDateField()),
              ],
            ),
            const SizedBox(height: 20),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }


  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _selectExpiryDate(context),
      child: AbsorbPointer(
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Fecha de Vencimiento',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          controller: TextEditingController(text: expiryDate),
        ),
      ),
    );
  }

  Widget _buildCreditCard() {
    String maskedNumber;
    if (cardNumber.isEmpty) {
      maskedNumber = '**** **** **** ****';
    } else if (cardNumber.length <= 4) {
      maskedNumber = cardNumber;
    } else {
      String hiddenPart = '*' * (cardNumber.length - 4);
      hiddenPart = hiddenPart.replaceAllMapped(RegExp(r'.{4}'), (match) => '**** ');
      maskedNumber = '$hiddenPart${cardNumber.substring(cardNumber.length - 4)}';
    }

    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.grey, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 20),
          Text(maskedNumber, style: _cardTextStyle),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardHolder, style: _cardTextStyle),
              Text(expiryDate, style: _cardTextStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPaymentOption('Tarjeta de crédito/débito', 'assets/images/visa.png', true),
          _buildPaymentOption('Yape', 'assets/images/YAPE.png', false),
          _buildPaymentOption('Transferencia Bancaria', 'assets/images/pago_efectivo.png', false),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String asset, bool selected) {
    return Row(
      children: [
        Radio(value: selected, groupValue: true, onChanged: (value) {}),
        Text(title, style: _textStyle),
        const Spacer(),
        Image.asset(asset, width: 18, height: 18),
      ],
    );
  }

Widget _buildTextField(String label, {bool isNumber = false, Function(String)? onChanged, List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print('Procesando pago...');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: const Text('Completar pago'),
      ),
    );
  }

  final TextStyle _titleStyle = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle _textStyle = const TextStyle(color: Colors.white, fontSize: 16);
  final TextStyle _cardTextStyle = const TextStyle(color: Colors.white, fontSize: 14);
}
