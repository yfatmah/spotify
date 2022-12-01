module Main (main) where

import Data.Aeson
import Data.ByteString.Lazy as BS (readFile)
import Data.Map

import Artist
import Common
import Items
import Printable
import Oauth
import App

main :: IO ()
main = do
  artistsFile <- BS.readFile "/Users/yamna/local/practice/spotify/src/artists.json"
  let items = decode artistsFile :: Maybe (Items Artist)
  case items of
    Nothing -> return ()
    Just (Items artists) -> do
      putStrLn $ print' artists
      print $ length artists
      print $ toList $ groupArtistsByGenre artists
      -- putStrLn $ print' $ groupArtistsByGenre artists
  return ()

{-
  flow
    oauth spotify account
    top artists, genres, songs
    playlists
      select a playlist
        order playlist based on favorite artists / genres / replayability
        create new playlists based on genres
        identify songs which aren't being played to remove
          option to remove each song
        remove duplicates in / across playlists
    artists
      favorite artists in different genres
    get recommendations based on seeds ???

    create playlists based on audio features & analysis
    use characteristics to create a recommended playlist

    pick an artist
      find recommended artist based on related artists

  maybe
    play next - add to front of queue ; not that useful in cli
    order songs in playlist based on how much they’re being played since they were added —

  if their algorithm can create better playlists and give better recommendation of songs based on current liked songs
  use categories to make recommendations

  output: show external urls so user can follow up


  given a playlist & top artists / tracks
    find tracks to potentially remove


  guessing game / wordle
    play 30 sec clip of song
    guess track / artist / album

-}
