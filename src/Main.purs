module Main where

import Prelude (Unit, bind, pure, unit, ($))
import Effect (Effect)
import Data.Maybe (Maybe(..))
import Web.HTML.Window (document)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.DOM.ParentNode
import Web.DOM.Node (setTextContent)
import Web.DOM.Element (toNode)




main :: Effect Unit
main = changeNodeInnerText "#some__query__selector" "my new text"



-- Find a node based on it's query selector and then change it's inner text
changeNodeInnerText :: String -> String -> Effect Unit
changeNodeInnerText qs newText = do

  w <- window
  d <- document w
  let parentNode = toParentNode d
  -- we grab the window, document, and then coerce it to a ParentNode
  -- this is necessary as the querySelector has the type
  -- :: QuerySelector -> ParentNode -> Effect (Maybe Element)

  element <- querySelector (QuerySelector qs) parentNode
  case element of (Just n) -> setTextContent newText $ toNode n
                  -- we need to convert our element to a node, using the
                  -- toNode function

                  Nothing  -> pure unit
                  -- If our query selector fails we return pure unit, doing
                  -- nothing

