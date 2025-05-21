// Base class for all album events
abstract class AlbumEvent {}

class LoadAlbumsEvent extends AlbumEvent {}

class RefreshAlbumsEvent extends AlbumEvent {}