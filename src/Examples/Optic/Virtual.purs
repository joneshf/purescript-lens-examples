module Examples.Optic.Virtual where

  {-
      This module provides an example of virtual fields.
      i.e. We could document `Length` as having a field for each unit.
  -}

  import Data.Function (on)

  import Optic.Core

  type MM = Number
  type CM = Number
  type M = Number
  type In = Number
  type Ft = Number

  newtype Length = Length MM

  instance showLength :: Show Length where
    show (Length n) = "Length (" ++ show n ++ ")"

  _Length :: LensP _ _
  _Length f (Length n) = Length <$> f n

  -- Provide ways of viewing the length as `MM`, `CM`, `M`, etc.
  mm :: LensP Length MM
  mm f (Length n) = f n <#> \n' -> Length n'

  cm :: LensP Length CM
  cm f (Length n) = f (n / 10) <#> \n' -> Length (n' * 10)

  m :: LensP Length M
  m f (Length n) = f (n / 1000) <#> \n' -> Length (n' * 1000)

  inches :: LensP Length In
  inches f (Length n) = f (n / 25.4) <#> \n' -> Length (n' * 25.4)

  feet :: LensP Length Ft
  feet f (Length n) = f (n / 304.8) <#> \n' -> Length (n' * 304.8)

  unitLen :: Length
  unitLen = Length 1

  tenmm :: Length
  tenmm = Length 10

  threeInches :: Length
  threeInches = unitLen # inches .~ 3
