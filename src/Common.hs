module Common where

import Data.Aeson
import Data.Aeson.Casing

aesonOptions :: String -> Options
aesonOptions xs = defaultOptions{fieldLabelModifier = snakeCase . drop 1}
