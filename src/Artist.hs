module Artist where

import Control.Monad
import Data.Aeson
import Data.Text
import GHC.Generics

import Common
import Data.Map
import Items
import Types

newtype Genre = Genre String deriving (Eq, Ord, Show, Generic)

newtype Popularity = Popularity Integer deriving (Eq, Show, Generic)

data Artist = Artist
  { aId :: String
  , aName :: String
  , aExternal_urls :: ExternalURL
  , aGenres :: [Genre]
  , aPopularity :: Popularity
  }
  deriving (Show, Generic)

groupArtistsByGenre :: [Artist] -> Map Genre [String]
groupArtistsByGenre as =
  groupByGenre as (fromList [(Genre "undefined", [])])
  where
    groupByGenre [] m = m
    groupByGenre ((Artist _ name _ genres _):rest) m =
      let
        genre =
          case genres of
            [] -> Genre "undefined"
            (g:_) -> g
        nm = insertWith (++) genre [name] m
      in groupByGenre rest nm

-- * zip name, top genre ; flatten to map with genre as key

-- ? maybe add some deduplication logic
-- ? keep all genres for artists

instance FromJSON Genre
instance FromJSON Popularity
instance FromJSON Artist where
  parseJSON = genericParseJSON $ aesonOptions "a"
instance FromJSON a => FromJSON (Items a)

-- instance ToJSON Genre
-- instance ToJSON Popularity
-- instance ToJSON Artist
-- instance ToJSON a => ToJSON (Items a)
