{-# LANGUAGE DeriveGeneric #-}

module Types where

import Data.Aeson
import GHC.Generics

newtype ID = ID String
  deriving (Eq, Show, Generic)

newtype Name = Name String
  deriving (Eq, Show, Generic)

newtype URI = URI String
  deriving (Eq, Show, Generic)

newtype ExternalURL = ExternalURL
  { spotify :: String
  }
  deriving (Eq, Show, Generic)

instance FromJSON ID
instance FromJSON Name
instance FromJSON URI
instance FromJSON ExternalURL

instance ToJSON ID
instance ToJSON Name
instance ToJSON URI
instance ToJSON ExternalURL
