module Track where

import Data.Aeson
import Data.Text
import GHC.Generics
import Types

data Track = Track
  { id :: String
  , name :: String
  , previewURL :: String
  , popularity :: Integer
  , artists :: [Artist]
  , album_images :: String
  }
  deriving (Eq, Show, Generic)
