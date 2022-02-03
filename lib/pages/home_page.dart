import 'dart:convert';

import '/models/kecamatan_model.dart';
import '/models/kelurahan_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

import '/models/city_model.dart';
import '/models/province_model.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  // * API KEY
  final String apiKey =
      'a3d6fbd9f3699b799e37738e3edb66fa6f77f51508c6e4f1f607781443415024';

  String? idProvince;
  String? idCity;
  String? idKecamatan;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            // * PROVINSI
            DropdownSearch<ProvinceModel>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              // * JIKA ADA PERUBAHAN, idProvince DIGANTI NILAI id
              onChanged: (value) => idProvince = value?.id,
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem?.name ?? 'Tidak Ada Data');
              },
              popupItemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item.name),
                );
              },
              onFind: (text) async {
                // * URL
                Uri url = Uri.parse(
                    'https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey');

                // * RESPONSE
                var response = await http.get(url);

                // * UBAH KE BENTUK OBJECT
                List dataProvince = json.decode(response.body)['value'];

                // * VARIABEL UNTUK MENAMPUNG DATA PROVINSI
                List<ProvinceModel> allModelProvince = [];

                // * TELUSURI SETIAP ELEMENT KEMUDIAN TAMBAHKAN KE VARIABEL allModelProvince
                dataProvince.forEach((element) {
                  allModelProvince.add(ProvinceModel.fromJson(element));
                });

                return allModelProvince;
              },
            ),
            SizedBox(
              height: 30,
            ),

            // * KOTA ATAU KABUPATEN
            DropdownSearch<CityModel>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              // * JIKA ADA PERUBAHAN, idCity DIGANTI NILAI id
              onChanged: (value) => idCity = value?.id,
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem?.name ?? 'Tidak Ada Data');
              },
              popupItemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item.name),
                );
              },
              onFind: (text) async {
                // * URL
                Uri url = Uri.parse(
                    'https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProvince');

                // * RESPONSE
                var response = await http.get(url);

                // * UBAH KE BENTUK OBJECT
                List dataCity = json.decode(response.body)['value'];

                // * VARIABEL UNTUK MENAMPUNG DATA KOTA/KABUPATEN
                List<CityModel> allModelCity = [];

                // * TELUSURI SETIAP ELEMENT KEMUDIAN TAMBAHKAN KE VARIABEL allModelCity
                dataCity.forEach((element) {
                  allModelCity.add(CityModel.fromJson(element));
                });

                return allModelCity;
              },
            ),
            SizedBox(
              height: 30,
            ),

            // * KECAMATAN
            DropdownSearch<KecamatanModel>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              // * JIKA ADA PERUBAHAN, idKecamatan DIGANTI NILAI id
              onChanged: (value) => idKecamatan = value?.id,
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem?.name ?? 'Tidak Ada Data');
              },
              popupItemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item.name),
                );
              },
              onFind: (text) async {
                // * URL
                Uri url = Uri.parse(
                    'https://api.binderbyte.com/wilayah/kecamatan?api_key=$apiKey&id_kabupaten=$idCity');

                // * RESPONSE
                var response = await http.get(url);

                // * UBAH KE BENTUK OBJECT
                List dataKecamatan = json.decode(response.body)['value'];

                // * VARIABEL UNTUK MENAMPUNG DATA KECAMATAN
                List<KecamatanModel> allModelKecamatan = [];

                // * TELUSURI SETIAP ELEMENT KEMUDIAN TAMBAHKAN KE VARIABEL allModelKecamatan
                dataKecamatan.forEach((element) {
                  allModelKecamatan.add(KecamatanModel.fromJson(element));
                });

                return allModelKecamatan;
              },
            ),
            SizedBox(
              height: 30,
            ),

            // * DESA ATAU KELURAHAN
            DropdownSearch<KelurahanModel>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              // * JIKA ADA PERUBAHAN, idKecamatan DIGANTI NILAI id
              onChanged: (value) => print(value?.id),
              dropdownBuilder: (context, selectedItem) {
                return Text(selectedItem?.name ?? 'Tidak Ada Data');
              },
              popupItemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item.name),
                );
              },
              onFind: (text) async {
                // * URL
                Uri url = Uri.parse(
                    'https://api.binderbyte.com/wilayah/kelurahan?api_key=$apiKey&id_kecamatan=$idKecamatan');

                // * RESPONSE
                var response = await http.get(url);

                // * UBAH KE BENTUK OBJECT
                List dataKelurahan = json.decode(response.body)['value'];

                // * VARIABEL UNTUK MENAMPUNG DATA KELURAHAN
                List<KelurahanModel> allModelKelurahan = [];

                // * TELUSURI SETIAP ELEMENT KEMUDIAN TAMBAHKAN KE VARIABEL allModelKelurahan
                dataKelurahan.forEach((element) {
                  allModelKelurahan.add(KelurahanModel.fromJson(element));
                });

                return allModelKelurahan;
              },
            ),
          ],
        ),
      ),
    );
  }
}
