module Examples.Optic.Traversal where

  {-
      This module provides examples of traversals and prisms.
  -}

  import Data.Either (Either(..))
  import Data.Maybe (Maybe(..))
  import Data.String (length)
  import Data.Tuple (Tuple(..))

  import Optic.Index
  import Optic.Core
  import Optic.Extended
  import Optic.Refractor.Lens
  import Optic.Refractor.Prism

  -- This is intentionally a messy structure.
  foo :: [Tuple (Either Number (Maybe String)) (Maybe Boolean)]
  foo =
    [ Tuple (Left 1) Nothing
    , Tuple (Left 2) (Just true)
    , Tuple (Right (Just "three")) (Just true)
    , Tuple (Right (Just "four")) (Just false)
    , Tuple (Right Nothing) Nothing
    ]

  -- We tack on " wat" to all the justs in the rights.
  bar = foo # mapped.._1.._Right.._Just ++~ " wat"
  -- We multiply all Lefts by 5.
  baz = foo # mapped.._1.._Left *~ 5
  -- We convert all of the `Maybe Boolean` to `Maybe String`.
  quux = foo # mapped.._2.._Just %~ (\b -> if b then "yes" else "nope")
  -- We get the length of the strings in each just in the rights.
  wibble = foo # mapped.._1.._Right.._Just %~ length
  -- We attempt (successfully) to set index 1 of `foo` to `wat`
  wobble = foo # ix 1 .~ wat
  -- We attempt (unsuccessfully) to set index 100 of `foo` to `wat`
  -- N.B. This is a safe runtime index.
  wubble = foo # ix 100 .~ wat

  -- We need to specify a type signature, otherwise the compiler complains.
  wat :: Tuple (Either Number (Maybe String)) (Maybe Boolean)
  wat = Tuple (Left 12) (Nothing)
