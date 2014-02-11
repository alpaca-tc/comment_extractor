--[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
--[-2-] | Pub/Sub envelope subscriber (p.76)
--[-3-] Pub/Sub envelope subscriber (p.76)
--[-4-] ^
{-[-5-]
[-6-]
[-7-][-end-]-}
{-[-8-]|
[-9-][-end-]-}
{-[-10-]| [-end-]-}
module Main where

import System.ZMQ4.Monadic
import Data.ByteString.Char8 (unpack)
import Control.Monad (when)
import Text.Printf

main :: IO ()
main =
    runZMQ $ do
        subscriber <- socket Sub
        connect subscriber "tcp://localhost:5563"
        subscribe subscriber "B"

        loop subscriber --[-25-]start listening for pub messages

    where
        loop subscriber = do
            --[-29-] read envelope with address
            receive subscriber >>= \addr -> liftIO $ printf "Address is %s\n" (unpack addr)
            --[-31-] read message content
            more <- moreToReceive subscriber
            when more $ do
                contents <- receive subscriber
                liftIO $ putStrLn (unpack contents)
            loop subscriber
