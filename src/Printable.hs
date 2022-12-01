module Printable where

import Control.Monad
import Data.List
import Data.Map

import Artist
import Items

class Printable a where
  print' :: a -> String

instance Printable a => Printable [a] where
  print' :: [a] -> String
  print' xs = intercalate "\n" $ print' <$> xs

instance Printable a => Printable (Items a) where
  print' :: Items a -> String
  print' (Items items) = intercalate "\n" $ print' <$> items

instance Printable Artist where
  print' :: Artist -> String
  print' (Artist id name external_urls genres popularity) = name ++ ":" ++ id

-- instance Printable (Map Genre [String]) where
--   print' :: Map Genre [String] -> String
--   print' m = printMap (toList m) ""
--    where
--     printMap [] xs = xs
--     printMap ((Genre g, as) : rest) xs =
--       printMap rest ((g ++ ":\n" (intercalate "\t" as)) ++ xs)
