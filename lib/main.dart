import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

/*
Textfieldda veri almak için controller gerekir.
Bunu tek bir alan için kullanılır.
Çoklu alan varsa textformfield kullanılır, yani controllerların aktif olabilmesi için widgetın stateful olması gerekir.

init içinde superi önce
dispose içinde superi sonra !!!!

*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProject(),
    );
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Input Tekrar"),
      ),
      body: TextFormfieldKullanimi(),
    );
  }
}

class TextFormfieldKullanimi extends StatefulWidget {
  const TextFormfieldKullanimi({super.key});

  @override
  State<TextFormfieldKullanimi> createState() =>
      _TextFormfieldKullanimiState();
}

class _TextFormfieldKullanimiState
    extends State<TextFormfieldKullanimi> {
  late final String _email, _password, _userName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          //Validate 3 şekil, buton, kullanıcı etkileşime girdiği an , ya da her zaman
          //AutoValidateMode
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //Textediting controllera ihtiyaç duymaz
              TextFormField(
                onSaved: (gelenUsername) {
                  _userName = gelenUsername!;
                },
                //Varsayılan değeri tanımlar
                //initialValue: "ahmetozgur",
                decoration: InputDecoration(
                  //hata mesajı renk değişimi
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Kullanıcı Adı",
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenPass) {
                  if (girilenPass!.isEmpty) {
                    return "Kullanıcı Adı boş olamaz.";
                  }
                  if (girilenPass.length < 4) {
                    return "5 karakterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (gelenEmail) {
                  _email = gelenEmail!;
                },
                //Varsayılan değeri tanımlar
                //initialValue: "ahmetozgur",
                decoration: InputDecoration(
                  //hata mesajı renk değişimi
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenEmail) {
                  if (!EmailValidator.validate(girilenEmail!)) {
                    return "Geçerli bir mail giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (gelenSifre) {
                  _password = gelenSifre!;
                },
                //Varsayılan değeri tanımlar
                //initialValue: "ahmetozgur",
                decoration: InputDecoration(
                  //hata mesajı renk değişimi
                  errorStyle: TextStyle(color: Colors.orange),
                  labelText: "Şifre",
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (girilenPass) {
                  if (girilenPass!.isEmpty) {
                    return "Şifre boş olamaz.";
                  }
                  if (girilenPass.length < 6) {
                    return "5 karakterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 180,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    //validate tamamnlandı mı kontrol etmek için
                    bool _isValidate = _formKey.currentState!
                        .validate();
                    if (_isValidate) {
                      //TFFden gelen verileri kaydetme işlemi
                      _formKey.currentState!.save();
                      String result =
                          "username:$_userName\nemail:$_email\npassword:$_password";
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(result)));
                      //Save işlemi olduktan sonra textleri temizlemek için
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text("Onayla"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      side: BorderSide(color: Colors.green, width: 3),
                    ),
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

class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() =>
      _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState
    extends State<TextFieldWidgetKullanimi> {
  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,
            //Seçili gelme olayı
            autofocus: true,
            //Satır sayısı
            maxLines: maxLineCount,
            //Girilecek karakter sayısı (TC)
            //maxLength: 11,
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),

              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green.shade300,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger) {},
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca
            onSubmitted: (String gelenDeger) {},
          ),
        ),
        TextField(),
      ],
    );
  }
}
