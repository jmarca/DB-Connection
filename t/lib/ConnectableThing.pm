use MooseX::Declare;
class ConnectableThing {
 method _build__connection_couchdb (Any $ladeeda) {
   # dummy method does nothing.  Needs to be put in *before* the with statement
   return;
 }
 with 'DB::Connection' => {
    'name'            => 'couchdb',
    'connection_type' => 'DB::CouchDB',
    'connection_delegation' =>
      qr/^(?:get.*|bulk.*|json.*|handle*|create.*|update.*|delete.*)/sxm,
  };

}
