///HMSConfig contains joining information of a user to a room
class HMSConfig {
  ///[userName] you want in the room you join.
  final String userName;
  ///unqiue string
  final String userId;
  ///[roomId] id of the room you want to join.
  final String roomId;
  ///[authToken] generated by 100ms servers.
  final String authToken;
  final String? metaData;
  ///[endPoint] where you have to make post request to get token.
  final String? endPoint;
  final bool shouldSkipPIIEvents;
  final bool isProdLink;
  HMSConfig(
      {this.userName = 'Flutter User',
      required this.userId,
      required this.roomId,
      required this.authToken,
      this.metaData,
      this.endPoint,
      this.shouldSkipPIIEvents = false,required this.isProdLink});

  Map<String, dynamic> getJson() {
    return {
      'user_name': userName,
      'user_id': userId,
      'room_id': roomId,
      'auth_token': authToken,
      'meta_data': metaData,
      'should_skip_pii_events': shouldSkipPIIEvents,
      'end_point': endPoint,
      'is_prod':isProdLink
    };
  }
}