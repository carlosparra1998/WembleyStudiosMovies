import 'movie.dart';

class APIResponse {
  late String status; 
  late String message;
  late List<Movie> response;

  APIResponse(
      this.status,
      this.message,
      this.response);

}
