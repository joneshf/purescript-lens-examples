# Module Documentation

## Module Examples.Optic.Records.Types

### Types

    data Designation where
      Avenue :: Designation
      Boulevard :: Designation
      Circle :: Designation
      Drive :: Designation
      Street :: Designation
      Way :: Designation

    data State where
      AL :: State
      AK :: State
      AZ :: State
      AR :: State
      CA :: State
      CO :: State
      CT :: State
      DE :: State
      FL :: State
      GA :: State
      HI :: State
      ID :: State
      IL :: State
      IN :: State
      IA :: State
      KS :: State
      KY :: State
      LA :: State
      ME :: State
      MD :: State
      MA :: State
      MI :: State
      MN :: State
      MS :: State
      MO :: State
      MT :: State
      NE :: State
      NV :: State
      NH :: State
      NJ :: State
      NM :: State
      NY :: State
      NC :: State
      ND :: State
      OH :: State
      OK :: State
      OR :: State
      PA :: State
      RI :: State
      SC :: State
      SD :: State
      TN :: State
      TX :: State
      UT :: State
      VT :: State
      VA :: State
      WA :: State
      WV :: State
      WI :: State
      WY :: State


### Type Class Instances

    instance showDesignation :: Show Designation

    instance showState :: Show State


## Module Examples.Optic.Records

### Types

    newtype Address where
      Address :: { state :: State, city :: String, street :: StreetRec } -> Address

    newtype Person where
      Person :: { address :: Address, lastName :: String, firstName :: String } -> Person

    newtype StreetRec where
      StreetRec :: { designation :: Designation, streetName :: String, number :: Number } -> StreetRec


### Type Class Instances

    instance showAddress :: Show Address

    instance showPerson :: Show Person

    instance showStreetRec :: Show StreetRec


### Values

    _Address :: LensP _ _

    _Person :: LensP _ _

    _StreetRec :: LensP _ _

    address :: LensP _ _

    changeFirstName :: String -> Person -> Person

    changeFirstNameLens :: String -> Person -> Person

    changeState :: State -> Person -> Person

    changeStateLens :: State -> Person -> Person

    changeStreetNumber :: Number -> Person -> Person

    changeStreetNumberLens :: Number -> Person -> Person

    city :: LensP _ _

    designation :: LensP _ _

    firstName :: LensP _ _

    fullName :: Getter Person String

    johnDoe :: Person

    lastName :: LensP _ _

    number :: LensP _ _

    state :: LensP _ _

    street :: LensP _ _

    streetName :: LensP _ _


## Module Examples.Optic.Bounded

### Types

    newtype Ball where
      Ball :: { y :: Number, x :: Number } -> Ball

    type LowerBound = Number

    type UpperBound = Number


### Type Class Instances

    instance showBall :: Show Ball


### Values

    _Ball :: LensP _ _

    clamp :: LowerBound -> UpperBound -> Number -> Number

    x :: LensP _ _

    y :: LensP _ _


## Module Examples.Optic.Virtual

### Types

    type CM = Number

    type Ft = Number

    type In = Number

    newtype Length where
      Length :: MM -> Length

    type M = Number

    type MM = Number


### Type Class Instances

    instance showLength :: Show Length


### Values

    _Length :: LensP _ _

    cm :: LensP Length CM

    feet :: LensP Length Ft

    inches :: LensP Length In

    m :: LensP Length M

    mm :: LensP Length MM

    tenmm :: Length


## Module Examples.Optic.Traversal

### Values

    foo :: [Tuple (Either Number (Maybe String)) (Maybe Boolean)]

    wat :: Tuple (Either Number (Maybe String)) (Maybe Boolean)



