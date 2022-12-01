{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module App where

import Data.Aeson
import Data.Text
import Network.HTTP.Types
import Yesod

import Oauth

data HelloWorld = HelloWorld

mkYesod
  "HelloWorld"
  [parseRoutes|
  / HomeR GET
  /login LoginR GET
  /callback CallbackR GET
|]

instance Yesod HelloWorld

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

getLoginR :: Handler Value
getLoginR = do
  -- pure $ object ["code" .= ("random" :: Text)]
  response <- connect "ahfgioagfhifga"
  sendStatusJSON ok200 response

getCallbackR :: Handler Value
getCallbackR =
  pure $
    object
      ["error" .= ("not implemented" :: Text)]

app :: IO ()
app = warp 3000 HelloWorld
