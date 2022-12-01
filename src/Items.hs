module Items where

import Data.Aeson
import GHC.Generics

newtype Items a = Items
  { items :: [a]
  }
  deriving (Show, Generic)

itemLength :: Maybe (Items a) -> Int
itemLength Nothing = 0
itemLength (Just (Items items)) = length items
