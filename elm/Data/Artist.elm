module Data.Artist (Artist, fromJson) where

import Json.Decode exposing ((:=))

type alias Artist =
  { id: Int
  , name: String
  }


fromJson : Json.Decode.Decoder Artist
fromJson =
  Json.Decode.object2 Artist
    ("id" := Json.Decode.int)
    ("name" := Json.Decode.string)
