import 'movie.dart';

class StreamResponse {
  late String status; 
  late List<Movie> response;


  StreamResponse(
      this.status,
      this.response);

}
