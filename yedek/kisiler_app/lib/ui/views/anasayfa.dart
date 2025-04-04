import 'package:flutter/material.dart';
import 'package:kisiler_app/data/entity/kisiler.dart';
import 'package:kisiler_app/ui/views/detay_sayfa.dart';
import 'package:kisiler_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> ara(String aramaKelimesi) async {
    print("Kişi Ara : $aramaKelimesi");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisiId: 1, kisiAd: 'Zeynep', kisiTel: '05416288099');
    var k2 = Kisiler(kisiId: 2, kisiAd: 'Aleyna', kisiTel: '0547895756');
    var k3 = Kisiler(kisiId: 3, kisiAd: 'Mahmut', kisiTel: '0985695756');
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    print("Kişi Sil : $kisi_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            aramaYapiliyorMu
                ? TextField(
                  decoration: const InputDecoration(hintText: "Ara"),
                  onChanged: (aramSonucu) {
                    ara(aramSonucu);
                  },
                )
                : const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                onPressed: () {
                  setState(() {
                    aramaYapiliyorMu = false;
                  });
                },
                icon: const Icon(Icons.clear),
              )
              : IconButton(
                onPressed: () {
                  setState(() {
                    aramaYapiliyorMu = true;
                  });
                },
                icon: const Icon(Icons.search),
              ),
        ],
      ),
      body: FutureBuilder<List<Kisiler>>(
        future: kisileriYukle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length, //3
              itemBuilder: (context, indeks) {
                //0,1,2
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetaySayfa(kisi: kisi),
                      ),
                    ).then((value) {
                     
                    });
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kisi.kisiAd,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(kisi.kisiTel),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${kisi.kisiAd} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: () {
                                      sil(kisi.kisiId);
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KayitSayfa()),
          ).then((value) {
            print("Anasayfaya dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
