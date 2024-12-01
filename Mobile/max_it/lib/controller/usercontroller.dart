import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  // Liste observable des clients simplifiée
  var clients = <Map<String, dynamic>>[].obs;

  // État de chargement
  var isLoading = false.obs;

  // Méthode pour récupérer les données des clients
  Future<void> fetchClients() async {
    try {
      isLoading.value = true;

      // URL de l'API
      const url = 'https://0d5e-197-239-64-129.ngrok-free.app/api/v1/orange-client/all-clients';

      // Requête GET
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          // Filtrer et ne garder que les champs nécessaires
          clients.value = data['data']['clients']
              .map<Map<String, dynamic>>((client) => {
                    'secret_word': client['secret_word']['secret'],
                    'firstName': client['firstName'],
                    'lastName': client['lastName'],
                    'date_of_birth': client['date_of_birth'],
                    'CNIB_number': client['CNIB_number'],
                  })
              .toList();
        } else {
          Get.snackbar('Erreur', 'Impossible de charger les clients.');
        }
      } else {
        Get.snackbar('Erreur', 'Serveur inaccessible.');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue : $e');
    } finally {
      isLoading.value = false;
    }
  }
}
