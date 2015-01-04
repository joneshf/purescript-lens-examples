module Examples.Optic.Bounded where

  {-
      This module provides an example of using lenses to enforce an invariant.
      i.e. a ball can never be outside of some box.
      N.B. These lenses are unlawful.
      In particular `view l (set l a b) = a` does not hold.
  -}

  import Optic.Core
  import Optic.Extended

  newtype Ball = Ball
    { x :: Number
    , y :: Number
    }

  instance showBall :: Show Ball where
    show (Ball b) = "Ball {x: " ++ show b.x ++ ", y:" ++ show b.y ++ "}"

  minX = 0
  minY = 0
  maxX = 100
  maxY = 100

  type LowerBound = Number
  type UpperBound = Number

  clamp :: LowerBound -> UpperBound -> Number -> Number
  clamp low high n = if n < low then low else if n > high then high else n

  _Ball :: LensP Ball {x :: Number, y :: Number}
  _Ball f (Ball b) = Ball <$> f b

  -- We specify the invariants here.
  -- So long as you only use these lenses to get or set values,
  -- you are guaranteed to have a value within the range.

  -- The x value can never be "lensed" out of [minX, maxX]
  x :: forall r. LensP {x :: Number | r} Number
  x f o = f o.x <#> \x' -> o{x = clamp minX maxX x'}

  -- The y value can never be "lensed" out of [minY, maxY]
  y :: forall r. LensP {y :: Number | r} Number
  y f o = f o.y <#> \y' -> o{y = clamp minY maxY y'}

  ball = Ball {x: 50, y: 50}

  moveEast10 :: Ball -> Ball
  moveEast10 b = b # _Ball..x +~ 10

  moveSouth30 :: Ball -> Ball
  moveSouth30 b = b # _Ball..y -~ 30

  moveNorthEast130 :: Ball -> Ball
  moveNorthEast130 b = b #~ do
    _Ball..x -= 50
    _Ball..y += 120
