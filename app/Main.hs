{-# LANGUAGE OverloadedStrings #-}

module Main where

import            Lib
import            Data.Maybe         (fromMaybe)
import            Data.Monoid        ((<>))
import qualified  Data.Text.Lazy as T  
import            System.Environment (lookupEnv)
import            Web.Scotty         (ActionM, ScottyM, scotty)
import            Web.Scotty.Trans   (html, get)
  

main :: IO ()
main = do 
        t <- fromMaybe "World"   <$> lookupEnv "TARGET"  
        pStr <- fromMaybe "8080" <$> lookupEnv "PORT"
        let p = read pStr :: Int
        scotty p (route $ T.pack t)
  
route :: T.Text -> ScottyM()
route t = get "/" $ hello t
  
hello :: T.Text -> ActionM()
hello t = html $ mconcat ["<!DOCTYPE html><html><head><title>"
                         ,"Haskell Kubernetes"
                         ,"</title></head><body><h1>"
                         ,"Hello " 
                         , t 
                         , "</h1></body></html>"] 
