module Exts.Json.Encode exposing (..)

{-| Extensions to the core `Json.Encode` library.

@docs set, dict, tuple2
-}

import Json.Encode exposing (..)
import Set as Set exposing (Set)
import Dict exposing (Dict)


{-| Encode a `Set` to a JSON array .
-}
set : (comparable -> Value) -> Set comparable -> Value
set encodeElement =
    list << List.map encodeElement << List.sort << Set.toList


{-| Encode a pair to a JSON array .
-}
tuple2 : (a -> Value) -> (b -> Value) -> ( a, b ) -> Value
tuple2 encodeKey encodeValue ( x, y ) =
    list [ encodeKey x, encodeValue y ]


{-| Encode a `Dict` to a JSON array .
-}
dict : (comparable -> Value) -> (v -> Value) -> Dict comparable v -> Value
dict encodeKey encodeValue =
    list << List.map (tuple2 encodeKey encodeValue) << Dict.toList
