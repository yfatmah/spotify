{-# LANGUAGE OverloadedStrings #-}

module Oauth where

import Data.Aeson
import Data.ByteString.Char8 qualified as BS
import Data.ByteString.Lazy qualified as LBS
import Network.HTTP.Client
import Network.HTTP.Client.TLS

clientID = "7ddd49349af749178d8f1c32b5335520"
clientSecret = "eaad373e6ead4bb0b115cebd7251adb4"

redirectURI = "http://localhost:3000/callback"

url = "https://accounts.spotify.com"

newtype Query = Query [(BS.ByteString, BS.ByteString)]
newtype Body = Body [(BS.ByteString, BS.ByteString)]
newtype Headers = Headers [(BS.ByteString, BS.ByteString)]
newtype Response = Response
  { statusCode :: String
  , body :: String
  }
  deriving (Eq, Show)

toQueryString :: Query -> BS.ByteString
toQueryString qs = BS.intercalate "$" $ fmap (\(k, v) -> mconcat [k, "=", v]) qs

makeRequest :: String -> String -> Headers -> Query -> Body -> Value
makeRequest method path body query = do
  manager <- newManager tlsManagerSettings
  let reqQuery = toQueryString query
  initReq <- parseRequest url ++ path
  let req =
        initReq{method = method, queryString = reqQuery, body = body}
  httpLbs req manager

-- {body, statusCode}

connectSpotifyAccount :: IO ()
connectSpotifyAccount = do
  let reqQuery =
        [ ("client_id", clientID)
        , ("response_type", "code")
        , ("redirect_uri", redirectURI)
        ] ::
          Query

  response <- makeRequest "GET" "/authorize" reqQuery []

  return ()

getToken :: Response -> IO ()
getToken response = do
  code <- getCode $ getResponseBody response
  let body =
        [ ("code", code)
        , ("redirect_uri", redirect_uri)
        , ("grant_type", "authorization_code") -- refresh_token
        ] ::
          Body
  let headers = [("Authorization", mconcat [clientID, ":", clientSecret])] -- base64
  res <- makeResponse "POST" "/api/token" headers [] body
  -- access_token expires_in refresh_token

  return ()
